#!/bin/sh
#BSUB -J ablation3_q_g_double_ama_mmexp_test
#BSUB -o /work3/s194253/results/ablation3_q_g_double_ama/mmexp_log.out
#BSUB -e /work3/s194253/results/ablation3_q_g_double_ama/mmexp_log.err
#BSUB -n 6
#BSUB -q gpuv100
#BSUB -gpu 'num=1:mode=exclusive_process'
#BSUB -W 2:00
#BSUB -R 'rusage[mem=5GB]'
#BSUB -R 'span[hosts=1]'
#BSUB -B
#BSUB -N


nvidia-smi
module load cuda/11.1
source /work3/s194253/envs/vqa/bin/activate
cd examples

python qlarifais_run_analyze.py --model_dir /work3/s194262/save/models/optimized/ablation3_q_g_double_ama \
    --torch_cache /work3/s194253 \
    --report_dir /work3/s194253/results/ablation3_q_g_double_ama/reports \
    --save_path /work3/s194253/results/ablation3_q_g_double_ama \
    --okvqa_file /work3/s194253/OKVQA_rich.json \
    --stratify_by start_words okvqa_categories question_length answer_length numerical_answers num_visual_objects visual_objects_types \
    --performance_report True \
    --plot_bars True \
    --tsne True \

python qlarifais_run_explainer.py --model_dir /work3/s194262/save/models/optimized/ablation3_q_g_double_ama \
    --torch_cache /work3/s194253 \
    --report_dir /work3/s194253/results/ablation3_q_g_double_ama/reports \
    --save_path /work3/s194253/results/ablation3_q_g_double_ama \
    --protocol_dir /zhome/b8/5/147299/Desktop/explainableVQA/examples/protocol \
    --analysis_type OR VisualNoise TextualNoise \
    --explainability_methods MMGradient \
    --protocol_name ablation3.txt \
    --show_all True \


