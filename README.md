**处理步骤：**

1. 首先，应通过 `dcm2niix` 等方法将 **dicom** 文件转换为 **nifty** 文件。然后使用 **bet** 生成脑掩膜以保留大脑部分。这将生成两幅图像：`*_bet` 和 `*_bet_mask`。接着在相位图中保留人脑部分：

`fslmaths your_phasemap -mul *_bet_mask your_B0Map`

2. 获取以弧度为单位的包裹相位（wrapped phase）。如果你有单独的整数格式的相位体积，则执行：

`fslmaths your_B0Map -mul 3.14159 -div 4096 phasemap`

3. 解包裹相位图像

`prelude -a magnitude_image -p phasemap -o unwrapped_image`

4. 计算磁化率

**例如：图像频率：**

`fslmaths unwrapped_image -div 2 -div 3.14159 -div delta_TE -div 1000000 delta_frequency`

`fslmaths delta_frequency -div Image_frequency -mul 1000000 susceptibility`

这些脚本在 FSL 中可用。然后将图像放入 matlab 并使用 `contourf` 制作等高线图以显示区分度：

图中描述的是一套基于 FSL (FMRIB Software Library) 的磁共振成像（MRI）数据处理流程，主要目的是从原始 DICOM 数据计算组织的**磁化率（Susceptibility）**。具体任务分解如下：

**总结**：该流程是定量磁化率成像（QSM）或相关 MRI 分析中的标准预处理步骤，最终目的是生成反映组织磁特性差异的图像，并建议在 MATLAB 中通过等高线图（contourf）进行可视化展示。

Processing Steps 任务分析
图中描述的是一套基于 FSL (FMRIB Software Library) 的磁共振成像（MRI）数据处理流程，主要目的是从原始 DICOM 数据计算组织的磁化率（Susceptibility）。具体任务分解如下：
1. 数据格式转换与脑提取 (Step 1)：
任务：将原始的 DICOM 格式医学影像转换为 NIfTI 格式（.nii），这是神经影像分析的标准格式。
工具：dcm2niix 用于转换，bet (Brain Extraction Tool) 用于去除头骨等非脑组织，生成脑掩膜（mask）。
操作：利用生成的掩膜从相位图（phasemap）中提取大脑区域，去除背景噪声。
2. 相位预处理 (Step 2)：
任务：将相位数据转换为弧度单位。MRI 扫描仪输出的相位值通常是整数格式，需要归一化到 [−𝜋,𝜋]范围。
计算：通过乘以 𝜋并除以最大整数值（此处假设为 4096）来实现。
3. 相位解包裹 (Step 3)：
任务：解决相位混叠问题。原始相位图是“包裹”的（wrapped），即在−𝜋到 𝜋之间跳变。为了进行定量计算，必须将其“解包裹”（unwrapped）成连续的相位图。
工具：使用 FSL 的 prelude 工具，结合幅度图（magnitude image）作为参考来进行解包裹。
4. 磁化率计算 (Step 4)：
任务：将解包裹后的相位图转换为物理量——磁化率（Susceptibility）。
计算：这是一个多步计算过程。首先根据相位和回波时间差（delta_TE）计算频率偏移（delta_frequency），然后结合主磁场强度（Image_frequency，通常指拉莫尔频率）计算出最终的磁化率图。
总结：该流程是定量磁化率成像（QSM）或相关 MRI 分析中的标准预处理步骤，最终目的是生成反映组织磁特性差异的图像，并建议在 MATLAB 中通过等高线图（contourf）进行可视化展示。

