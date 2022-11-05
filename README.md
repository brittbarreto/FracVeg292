# FracVeg292
Fractional vegetation cover project for Machine Learning 292

## Project Overview

```mermaid
flowchart TD
    GT[/Ground Truth point data .csv/]
    OP[/Orthophotos .tiff/]
    PD[/Planet Data .tiff/]

    PPR[Preprocess Extent + Resample]
    BNC[[Binary Classification Model]]
    GDLW[GDAL Warp]
    VIS[Calculate VIs]
    MFVC[[Model for FVC]]

    FVC(((FVC 3m)))

    PD -->VIS
    VIS -->|VIs + bands|MFVC


    OP -->PPR
    PPR -->|Fixed Orthophotos|BNC
    BNC -->|11 Orthophotos + Binary Classes|GDLW
    GDLW -->|Ground Truth FVC|MFVC
    MFVC -->FVC

    GT -->BNC
```