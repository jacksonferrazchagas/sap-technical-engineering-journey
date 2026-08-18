$ErrorActionPreference = "Stop"

$project = "project\hamilton-steel-manufacturing"
$sprint = "$project\sprints\sprint-02"
$screenshots = "$sprint\screenshots"
$technical = "$sprint\technical"
$srcTable = "src\abap\tables"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Creating Sprint 02 documentation..." -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

$folders = @(
    $sprint,
    $screenshots,
    $technical,
    $srcTable
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
}

$tableSource = @'
@EndUserText.label : 'Hamilton Steel Production Records'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zhsm_production {

  key client        : abap.clnt not null;
  key production_id : abap.char(10) not null;

  material_id       : abap.char(18) not null;

  @Semantics.quantity.unitOfMeasure : 'zhsm_production.unit'
  quantity          : abap.quan(13,3) not null;

  unit              : abap.unit(3) not null;

  production_date   : abap.dats not null;
  shift             : abap.char(10) not null;
  work_center       : abap.char(12) not null;
  cost_center       : abap.char(10) not null;
  status            : abap.char(12) not null;

  @Semantics.amount.currencyCode : 'zhsm_production.currency'
  material_cost     : abap.curr(15,2) not null;

  @Semantics.amount.currencyCode : 'zhsm_production.currency'
  labor_cost        : abap.curr(15,2) not null;

  currency          : abap.cuky not null;

}
'@

Set-Content -Path "$srcTable\zhsm_production.ddls" -Value $tableSource -Encoding UTF8

$sprintReadme = @'
# Sprint 02 — Production and Cost Data Model

## Status

**Completed**

## Objective

Design and implement the first persistent business data model for Hamilton Steel Manufacturing using the SAP ABAP Dictionary and ABAP Cloud.

## Business Scenario

Hamilton Steel Manufacturing needs a centralized production record containing operational and financial information.

## SAP Object

| Property | Value |
|---|---|
| Object Type | Database Table |
| Object Name | `ZHSM_PRODUCTION` |
| Description | Hamilton Steel Production Records |
| Package | `ZDNR` |
| SAP System | `TRL` |
| Language Version | ABAP for Cloud Development |
| Development Tool | Eclipse ADT |
| Status | Active |

## Data Model

| Field | Purpose |
|---|---|
| `CLIENT` | SAP client |
| `PRODUCTION_ID` | Unique production record identifier |
| `MATERIAL_ID` | Material being produced |
| `QUANTITY` | Production quantity |
| `UNIT` | Unit of measure |
| `PRODUCTION_DATE` | Date of production |
| `SHIFT` | Production shift |
| `WORK_CENTER` | Production work center |
| `COST_CENTER` | Financial cost center |
| `STATUS` | Production record status |
| `MATERIAL_COST` | Direct material cost |
| `LABOR_COST` | Direct labor cost |
| `CURRENCY` | Currency for monetary values |

## Semantic Modeling

### Quantity and Unit of Measure

```abap
@Semantics.quantity.unitOfMeasure : 'zhsm_production.unit'
quantity : abap.quan(13,3) not null;

unit : abap.unit(3) not null;
```

### Amount and Currency

```abap
@Semantics.amount.currencyCode : 'zhsm_production.currency'
material_cost : abap.curr(15,2) not null;

@Semantics.amount.currencyCode : 'zhsm_production.currency'
labor_cost : abap.curr(15,2) not null;

currency : abap.cuky not null;
```

## Design Decision — Total Cost

`TOTAL_COST` is intentionally not stored in the physical database table.

It will later be derived as:

```text
TOTAL_COST = MATERIAL_COST + LABOR_COST
```

## Validation Performed

- Database table created in Eclipse ADT
- Table activated successfully
- ABAP Cloud language version confirmed
- SAP package confirmed
- Data Preview opened successfully
- Physical columns verified
- SAP BTP ABAP Environment confirmed in the BTP Cockpit

## Evidence

![Active Database Table](screenshots/01-zhsm-production-active.png)

![Data Preview](screenshots/02-zhsm-production-data-preview.png)

![Object Properties](screenshots/03-zhsm-production-properties.png)

![SAP BTP ABAP Environment](screenshots/04-sap-btp-abap-environment.png)

## Next Sprint

### Sprint 03 — Production Data Access Layer

1. Create test production records.
2. Validate persisted data.
3. Create the first CDS View Entity.
4. Prepare the foundation for RAP and OData.
'@

Set-Content -Path "$sprint\README.md" -Value $sprintReadme -Encoding UTF8

$dataDictionary = @'
# ZHSM_PRODUCTION — Technical Data Dictionary

| Field | ABAP Type | Key | Business Meaning |
|---|---|---:|---|
| CLIENT | `abap.clnt` | Yes | SAP client |
| PRODUCTION_ID | `abap.char(10)` | Yes | Production transaction identifier |
| MATERIAL_ID | `abap.char(18)` | No | Produced material |
| QUANTITY | `abap.quan(13,3)` | No | Production quantity |
| UNIT | `abap.unit(3)` | No | Unit of measure |
| PRODUCTION_DATE | `abap.dats` | No | Production date |
| SHIFT | `abap.char(10)` | No | Production shift |
| WORK_CENTER | `abap.char(12)` | No | Operational work center |
| COST_CENTER | `abap.char(10)` | No | Financial cost center |
| STATUS | `abap.char(12)` | No | Production status |
| MATERIAL_COST | `abap.curr(15,2)` | No | Direct material cost |
| LABOR_COST | `abap.curr(15,2)` | No | Direct labor cost |
| CURRENCY | `abap.cuky` | No | Currency code |

## Semantic References

`QUANTITY` → `UNIT`

`MATERIAL_COST` → `CURRENCY`

`LABOR_COST` → `CURRENCY`
'@

Set-Content -Path "$technical\data-dictionary.md" -Value $dataDictionary -Encoding UTF8

$sprintReview = @'
# Sprint 02 Review

## Sprint Goal

Create the first real persistent SAP business object for production and cost tracking.

## Result

**Sprint Goal Achieved.**

The `ZHSM_PRODUCTION` database table was successfully created and activated in the SAP ABAP Cloud environment.

## Current Limitation

The database table currently contains zero records.

Test data creation will be addressed in Sprint 03.
'@

Set-Content -Path "$technical\sprint-review.md" -Value $sprintReview -Encoding UTF8

$downloads = Join-Path $env:USERPROFILE "Downloads"

$imageFiles = @(
    "01-zhsm-production-active.png",
    "02-zhsm-production-data-preview.png",
    "03-zhsm-production-properties.png",
    "04-sap-btp-abap-environment.png"
)

Write-Host ""
Write-Host "Checking screenshots in Downloads..." -ForegroundColor Yellow

foreach ($image in $imageFiles) {
    $source = Join-Path $downloads $image
    $destination = Join-Path $screenshots $image

    if (Test-Path $source) {
        Copy-Item -Path $source -Destination $destination -Force
        Write-Host "[COPIED] $image" -ForegroundColor Green
    } else {
        Write-Host "[MISSING] $image" -ForegroundColor Yellow
    }
}

$checklist = @'
# Sprint 02 Screenshot Checklist

- [ ] `01-zhsm-production-active.png`
- [ ] `02-zhsm-production-data-preview.png`
- [ ] `03-zhsm-production-properties.png`
- [ ] `04-sap-btp-abap-environment.png`
'@

Set-Content -Path "$screenshots\README.md" -Value $checklist -Encoding UTF8

$today = Get-Date -Format "yyyy-MM-dd"
$change = @"

## $today — Sprint 02

- Created `ZHSM_PRODUCTION`
- Added production and cost data model
- Added quantity/unit semantic relationship
- Added financial amount/currency semantic relationships
- Validated table activation
- Validated Data Preview
- Confirmed SAP BTP ABAP Environment
- Added Sprint 02 technical documentation
"@

Add-Content -Path "CHANGELOG.md" -Value $change -Encoding UTF8

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "Sprint 02 documentation created." -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
git status
