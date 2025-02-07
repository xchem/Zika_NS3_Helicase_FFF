# FFF_Template

## 2. Setup

- [x] Define merging opportunities by creating tags of LHS hits in Fragalysis
- [ ] Download target from Fragalysis and place the .zip archive in the repo
- [ ] Setup target in BulkDock 

```
cp -v TARGET_NAME.zip $BULK/TARGETS
cd $BULK
python -m bulkdock extract TARGET_NAME
python -m bulkdock setup TARGET_NAME
```

- [ ] Copy the `aligned_files` directory from `$BULK/TARGETS/TARGET_NAME/aligned_files` into this repository

```
cd - 
cp -rv $BULK/TARGETS/TARGET_NAME/aligned_files .
```

## 3. Compound Design

- [ ] run the notebook `hippo/1_merge_prep.ipynb`

### Fragmenstein

For each merging hypothesis (i.e. HYPOTHESIS_NICKNAME)

- [ ] go to the fragmenstein subdirectory `cd fragmenstein`
- [ ] queue fragmenstein job 

```sb.sh --job-name "TARGET_NAME_HYPOTHESIS_NICKNAME_fragmenstein" --mem 16000 $HOME2/slurm/run_bash_with_conda.sh run_fragmenstein.sh HYPOTHESIS_NICKNAME```

This will create outputs in the chosen HYPOTHESIS_NICKNAME subdirectory:

- **`HYPOTHESIS_NICKNAME_fstein_bulkdock_input.csv`: use this for BulkDock placement**
- `output`: fragmenstein merge poses in subdirectories
- `output.sdf`: fragmenstein merge ligand conformers
- `output.csv`: fragmenstein merge metadata

- [ ] placement with bulkdock

```
cp -v HYPOTHESIS_NICKNAME_fstein_bulkdock_input.csv $BULK/INPUTS/TARGET_HYPOTHESIS_NICKNAME_fstein.csv
cd $BULK
python -m bulkdock place TARGET_NAME INPUTS/TARGET_HYPOTHESIS_NICKNAME_fstein.csv
```

- [ ] monitor placements (until complete)

```
python -m bulkdock status
```

- [ ] export Fragalysis SDF

```
sb.sh --job-name "bulkdock_out" $HOME2/slurm/run_python.sh -m bulkdock to-fragalysis TARGET OUTPUTS/SDF_FILE METHOD_NAME
```

### Fragment Knitwork

Running Fragment Knitting currently requires access to a specific VM known as `graph-sw-2`. If you don't have access, skip this section

- [ ] `git add`, `commit` and `push` the contents of `aligned_files` and `knitwork` to the repository
- [ ] `git clone` the repository on `graph-sw-2`
- [ ] navigate to the `knitwork` subdirectory

Then, for each merging hypothesis:

- [ ] Run the "fragment" step of FragmentKnitwork: `./run_fragment.sh HYPOTHESIS_NICKNAME`
- [ ] Run the pure "knitting" step of FragmentKnitwork: `./run_knitwork_pure.sh HYPOTHESIS_NICKNAME`
- [ ] Run the impure "knitting" step of FragmentKnitwork: `./run_knitwork_impure.sh HYPOTHESIS_NICKNAME`
- [ ] Create the BulkDock inputs: `python to_bulkdock.py HYPOTHESIS_NICKNAME`
- [ ] `git add`, `commit` and `push` the CSVs created by the previous step
- [ ] back on `cepheus-slurm` pull the latest changes
- [ ] Run BulkDock placement as for Fragmenstein above

```
cp -v HYPOTHESIS_NICKNAME_knitwork_pure.csv $BULK/INPUTS/TARGET_HYPOTHESIS_NICKNAME_knitwork_pure.csv
cp -v HYPOTHESIS_NICKNAME_knitwork_impure.csv $BULK/INPUTS/TARGET_HYPOTHESIS_NICKNAME_knitwork_impure.csv
cd $BULK
python -m bulkdock place TARGET_NAME INPUTS/TARGET_HYPOTHESIS_NICKNAME_knitwork_pure.csv
python -m bulkdock place TARGET_NAME INPUTS/TARGET_HYPOTHESIS_NICKNAME_knitwork_impure.csv
```

- [ ] Export Fragalysis SDF as for Fragmenstein

## 4. Scaffold selection

### Syndirella retrosynthesis
### Review chemistry
### HIPPO filtering
### Fragalysis curation

## 5. Syndirella elaboration

## 6. HIPPO

### Load elaborations
### Quote reactants
### Solve routes
### Calculate interactions
### Generate random recipes
### Score random recipes
### Optimise best recipes
### Create proposal web page

## 7. Review & order

### Review chemistry
### Order reactants
