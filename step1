# 定义文件路径
PHASE_FILE="/data2/hejl/B0shim_auto/nii_gz/a_B0map_shima_ph.nii.gz"
MAG_FILE="B0shim_auto/nii_gz/a_Echo1_image_shim.nii.gz" # 假设这是对应的幅度图
MASK_OUTPUT="/data2/hejl/B0shim_auto/brain_shim"
FINAL_PHASE="/data2/hejl/B0shim_auto/B0map_only_brain_shim"

# 1. 对幅度图执行 BET 获取掩膜
bet "$MAG_FILE" "$MASK_OUTPUT" -m -f 0.5 -g 0

# 2. 使用 fslmaths 将生成的掩膜应用到相位图上
# -mul 表示逐体素相乘，从而去除相位图背景中的噪声
fslmaths "$PHASE_FILE" -mul "${MASK_OUTPUT}_mask.nii.gz" "$FINAL_PHASE"
