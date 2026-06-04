import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import datasets, transforms
from torch.utils.data import DataLoader
import numpy as np

# Set device
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# Hyperparameters
num_epochs    = 35
learning_rate = 0.0001
batch_size    = 64
patience      = 5

# ── Model ─────────────────────────────────────────────────────────────────
class SimpleCNN(nn.Module):
    def __init__(self):
        super(SimpleCNN, self).__init__()
        self.conv1 = nn.Conv2d(in_channels=1, out_channels=16, kernel_size=3, padding=0)
        self.relu1 = nn.ReLU()
        self.pool1 = nn.MaxPool2d(kernel_size=2, stride=2)
        # 28x28 → conv(no pad) → 26x26 → maxpool(2x2) → 13x13
        self.fc = nn.Linear(16 * 13 * 13, 10)

    def forward(self, x):
        x = self.pool1(self.relu1(self.conv1(x)))
        x = x.view(x.size(0), -1)
        x = self.fc(x)
        return x

# ── Main ──────────────────────────────────────────────────────────────────
def main():
    print(f"Using device: {device}")

    # ── Transforms ────────────────────────────────────────────────────────
    # Training: augmentation to simulate canvas drawing variation
    # All augmentations applied BEFORE converting to tensor so they work on PIL images.
    # Final output: float32 tensor in [0, 255] — matches hardware input expectation.
    train_transform = transforms.Compose([
        transforms.RandomRotation(degrees=15),                          # ±15° rotation
        transforms.RandomAffine(
            degrees=0,
            translate=(0.15, 0.15),                                     # up to 15% shift
            scale=(0.8, 1.2),                                           # 80–120% zoom
        ),
        transforms.Lambda(lambda x: torch.from_numpy(np.array(x)).float()),  # PIL → float32 [0,255]
        transforms.Lambda(lambda x: x.unsqueeze(0)),                    # → (1, 28, 28)
    ])

    # Validation/test: no augmentation, same tensor format
    test_transform = transforms.Compose([
        transforms.Lambda(lambda x: torch.from_numpy(np.array(x)).float()),
        transforms.Lambda(lambda x: x.unsqueeze(0)),
    ])

    # ── Full MNIST dataset (60k train / 10k test) ─────────────────────────
    train_dataset = datasets.MNIST(root='./data', train=True,
                                   transform=train_transform, download=True)
    test_dataset  = datasets.MNIST(root='./data', train=False,
                                   transform=test_transform,  download=True)

    train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True,  num_workers=2)
    test_loader  = DataLoader(test_dataset,  batch_size=batch_size, shuffle=False, num_workers=2)
    print(f"Train: {len(train_dataset)}  Test: {len(test_dataset)}")

    model     = SimpleCNN().to(device)
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=learning_rate)

    best_loss         = float('inf')
    epochs_no_improve = 0

    for epoch in range(num_epochs):
        # ── Train ────────────────────────────────────────────────────────
        model.train()
        train_loss = 0.0
        for images, labels in train_loader:
            images, labels = images.to(device), labels.to(device)
            outputs = model(images)
            loss    = criterion(outputs, labels)
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()
            train_loss += loss.item() * images.size(0)
        train_loss /= len(train_loader.dataset)

        # ── Validate ─────────────────────────────────────────────────────
        model.eval()
        val_loss, correct, total = 0.0, 0, 0
        with torch.no_grad():
            for images, labels in test_loader:
                images, labels = images.to(device), labels.to(device)
                outputs = model(images)
                val_loss += criterion(outputs, labels).item() * images.size(0)
                _, predicted = torch.max(outputs, 1)
                total   += labels.size(0)
                correct += (predicted == labels).sum().item()
        val_loss  /= len(test_loader.dataset)
        accuracy   = 100 * correct / total
        print(f"Epoch [{epoch+1}/{num_epochs}]  "
              f"Train Loss: {train_loss:.4f}  "
              f"Val Loss: {val_loss:.4f}  "
              f"Val Acc: {accuracy:.2f}%")

        # ── Early stopping ───────────────────────────────────────────────
        if val_loss < best_loss:
            best_loss         = val_loss
            epochs_no_improve = 0
            torch.save(model.state_dict(), 'cnn_mnist_weights.pth')
            print(f"  → Saved best model (val_loss={best_loss:.4f})")
        else:
            epochs_no_improve += 1
            if epochs_no_improve == patience:
                print(f"Early stopping at epoch {epoch+1}.")
                break

    print("Training complete.")

if __name__ == '__main__':
    torch.manual_seed(42)
    np.random.seed(42)
    main()