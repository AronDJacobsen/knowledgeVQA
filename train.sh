#!/bin/sh
#BSUB -J predict_model_demo
#BSUB -o predict_demo%J.out
#BSUB -e predict_demo%J.err
#BSUB -q hpc
#BSUB -n 1
#BSUB -R "rusage[mem=32G]"
#BSUB -R "span[hosts=1]"
#BSUB -W 24:00
#BSUB -B
#BSUB -N

source vqa/bin/activate

cd utils
export PYTHONPATH=.
cd ..

cd mmf
mmf_run config="configs/experiments/predictive_vqa/defaults.yaml" \
model=predictive_vqa \
dataset=okvqa \
run_type=train_val
