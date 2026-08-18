# ZHSM_PRODUCTION â€” Technical Data Dictionary

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

`QUANTITY` â†’ `UNIT`

`MATERIAL_COST` â†’ `CURRENCY`

`LABOR_COST` â†’ `CURRENCY`
