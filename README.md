# Realistic Lite Shaderpack

一个面向低配电脑的《我的世界》写实风格光影包。目标是在不明显牺牲观感的前提下，减少高开销效果，用轻量级色调映射、真实雾化、柔和日照、水面菲涅尔高光和低成本颜色分级来营造写实画面。

## 特点

- 写实色彩：使用电影感 ACES 风格色调映射，降低过曝并保留天空与地表层次。
- 低配友好：默认不启用重型体积云、屏幕空间全局光照或高采样模糊。
- 水面增强：使用低成本菲涅尔高光、轻微波动和透明度变化模拟自然水体。
- 远景雾化：用距离雾降低远景锯齿感，同时提升真实空气透视效果。
- 可调参数：通过 `shaders.properties` 暴露性能与观感相关选项。

## 兼容性

建议使用以下任一方式加载：

- OptiFine 光影
- Iris Shaders + Sodium

目标版本为支持传统 OptiFine shader pipeline 的 Java 版 Minecraft。不同 Minecraft、OptiFine 或 Iris 版本的内置 uniform 可能略有差异，如出现编译错误，可先关闭其它资源包或降低光影配置。

## 安装

1. 将整个 `RealisticLiteShaderpack` 文件夹复制到 Minecraft 的 `shaderpacks` 目录。
2. 在游戏中进入 `选项 > 视频设置 > 光影`。
3. 选择 `RealisticLiteShaderpack`。
4. 低配电脑建议先使用游戏内较低渲染距离，例如 8 到 12 chunks。

## 性能建议

- 渲染距离：8 到 12 chunks。
- 阴影距离：保持默认或降低到 64 到 80。
- 云：建议关闭原版云。
- 若帧率较低，优先降低游戏渲染距离，而不是关闭本光影的色调映射。

## 项目结构

- `shaders/`：OptiFine/Iris 光影源码。
- `shaders/common/`：公共色彩、雾化和水面函数。
- `shaders/shaders.properties`：光影设置与默认配置。
- `shaders/lang/`：中英文设置名称。

## 设计取舍

本项目刻意避免使用高成本的多次采样屏幕空间反射、复杂体积光和重型景深。写实感主要来自色调、对比、空气透视和水面高光，因此更适合低配电脑或笔记本使用。
