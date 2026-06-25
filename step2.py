# 定义文件路径
PHASE_FILE="/data2/hejl/B0shim_auto/B0map_only_brain_shim.nii.gz"
PHASE_RAD="/data2/hejl/B0shim_auto/B0map_only_brain_shim_rad"

# MRI 扫描仪输出的相位通常为整数，取值范围 [-4096, 4096] 对应 [-π, π]
PHASE_MAX=4096
PI=3.141592653589793

# 转换为弧度: rad = phase_int * π / PHASE_MAX
fslmaths "$PHASE_FILE" -div "$PHASE_MAX" -mul "$PI" "$PHASE_RAD"
