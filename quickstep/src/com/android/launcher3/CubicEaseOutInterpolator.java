package com.android.launcher3;

import android.view.animation.Interpolator;

/**
 * 函数曲线: https://easings.net/zh-cn#easeOutCubic
 * 公式: y(x)=1−(1−x)^3,x∈[0,1]
 */
public class CubicEaseOutInterpolator implements Interpolator {
  @Override
  public float getInterpolation(float input) {
    input -= 1;
    return input * input * input + 1;
  }
}
