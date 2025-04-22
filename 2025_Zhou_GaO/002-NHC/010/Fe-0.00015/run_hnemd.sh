#!/bin/sh

prefix=GaO

#--------------
PAR='main'
NOD=1
CPU_CORE=2
TIM='160:00:00'
JOB=$1
#--------------

#for i in {001..001} #按顺序从job-001到116做静态vasp计算,根据生成的文件夹设定
for i in 002 003 004 005;
do
   rm job-$i
   mkdir job-$i
   cd job-$i
   rm job*
   cp ../model.xyz .
   #--------run.in-----
cat << END_OF_runin > run.in
potential    ../nep.txt
velocity     300

ensemble    npt_ber 300 300 100  0 0 0 0 0 0 54 54 54 54 54 54 2000
time_step    1
dump_thermo 1000
run         500000

ensemble     nvt_nhc 300 300 100
dump_thermo  1000
run          500000

ensemble     nvt_nhc 300 300 100
compute_hnemd 1000 0 0.00015 0
# compute_shc   2 250 2 1000 200.0
# sampling interval is 2, maximum number of correlation steps is 250
# transport direction is z,consider 1000 frequency points and maximum angular frequency is 200 THz
run           10000000

END_OF_runin

cat << END_OF_CAT > sub.out
#!/bin/bash

#SBATCH -o job.%j.out
#SBATCH --job-name=${prefix}
#SBATCH -p ${PAR}
#SBATCH --nodes=${NOD}
#SBATCH --ntasks-per-node=${CPU_CORE}
#SBATCH --gres=gpu:1                # 请求 1 个 GPU

module load oneapi/2023.0.0
export I_MPI_FABRICS=shm:ofi
module load GPUMD/202412
ulimit -s unlimited


#CUDA_VISIBLE_DEVICES=2 gpumd < run.in > run.out

gpumd < run.in > run.out

END_OF_CAT

chmod 755 sub.out
sbatch < sub.out

  
   cd ..
   
done
