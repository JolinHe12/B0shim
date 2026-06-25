# 定义文件路径
PHASE_UNWRAPPED="/data2/hejl/B0shim_auto/B0map_only_brain_shim_unwrapped.nii.gz"
DELTA_FREQ="/data2/hejl/B0shim_auto/delta_frequency_shim"
SUSCEPTIBILITY="/data2/hejl/B0shim_auto/susceptibility_shim"

# 扫描参数（来自 a_Echo1_image_shima_.json，单位：TE 为秒，ImagingFrequency 为 MHz）
TE1=0.00492
TE2=0.00984
DELTA_TE=$(awk "BEGIN {print $TE2 - $TE1}")
IMAGE_FREQ=210.912094
TWO_PI=6.283185307179586

# 1. 频率偏移 (Hz): delta_f = phi / (2 * pi * delta_TE)
fslmaths "$PHASE_UNWRAPPED" -div "$DELTA_TE" -div "$TWO_PI" "$DELTA_FREQ"

# 2. 磁化率 (ppm): chi = delta_f / ImagingFrequency
fslmaths "$DELTA_FREQ" -div "$IMAGE_FREQ" "$SUSCEPTIBILITY"
