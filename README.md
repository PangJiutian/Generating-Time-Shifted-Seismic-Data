# Seismic Well-Tie: Generating Time-Shifted Seismic Data

This project explores the challenge of misalignment between well logs and seismic data due to time shifts caused by inaccurate time-depth relationships (TDR). Such misalignment—where seismic peaks and troughs do not align with well-log events—poses a serious problem for supervised learning models, preventing them from learning correct input-label relationships.

To address this, we simulate realistic time-shift scenarios using synthetic data and train a neural network to estimate and correct these shifts.

## 📊 Dataset

- **Model**: Marmousi velocity model
- **Domain**: Depth-domain simulation

## 🧪 Experiment Overview

### 1. Compute True TDR

- A velocity model in the depth domain is used to compute a ground-truth TDR.
- The depth sampling interval is set to `1.25 km` (unit illustrative).
- Synthetic seismic traces are generated based on this true TDR.

### 2. Simulate Time-Shifted Seismic Data

- Perturb the true TDR to obtain a time-shifted version.
- Use the shifted TDR to generate synthetic seismic traces that exhibit realistic time shifts.
- The difference between the original and shifted TDR is used as the label for supervised learning.

This process generates a dataset of aligned and misaligned seismic traces to train a model for time-shift estimation and correction.

## 🚀 Objective

To develop a neural network capable of learning the mapping from misaligned seismic traces to accurate time-shift corrections, enabling better well-to-seismic integration in real-world applications.

