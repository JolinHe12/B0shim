# 定义文件路径
PHASE_WRAPPED="/data2/hejl/B0shim_auto/B0map_only_brain_shim_rad.nii.gz"
MAG_FILE="/data2/hejl/B0shim_auto/nii_gz/a_Echo1_image_shim.nii.gz"
BRAIN_MASK="/data2/hejl/B0shim_auto/brain_shim_mask.nii.gz"
PHASE_UNWRAPPED="/data2/hejl/B0shim_auto/B0map_only_brain_shim_unwrapped"

# 使用 prelude 解包裹相位：幅度图作为参考权重，脑掩膜限制解包裹区域
prelude -p "$PHASE_WRAPPED" -a "$MAG_FILE" -m "$BRAIN_MASK" -f -o "$PHASE_UNWRAPPED"
