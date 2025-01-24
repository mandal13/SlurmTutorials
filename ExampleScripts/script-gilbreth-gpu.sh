#!/bin/bash                                                                                                                                                                                                        
# for running on gilbreth 
 
 
module load learning/conda-2020.11-py38-gpu
module load ml-toolkit-gpu/all 
 
host=`hostname -s`
echo $CUDA_VISIBLE_DEVICES
 
#start training from scratch
python main.py --train --log_dir "./logdir" --train_data_dir "./data/train_data/" --val_data_dir "./data/val_data/"  --epochs 5 --lr 1.0e-4 --batch_size 4 --print_freq 2 
 
#restart training
python main.py --train --log_dir "./logdir" --train_data_dir "./data/train_data/" --val_data_dir "./data/val_data/"  --epochs 5 --lr 1.0e-4 --batch_size 4 --print_freq 2 --restart --log_file "model05.pth"


# sbatch  -A standby --nodes=1 --gres=gpu:1 -t 00:01:00 gpu_hello.sub

# sbatch  -A standby --nodes=1 --gres=gpu:1 -t 00:01:00 gpu_hello.sub
# sbatch  -A standby --nodes=1 --gpus-per-node=1 -t 00:01:00 gpu_hello.sub
# sbatch  -A standby --nodes=1 --gpus-per-task=1 -t 00:01:00 gpu_hello.sub
