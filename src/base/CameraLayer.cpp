/////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Tencent is pleased to support the open source community by making libpag available.
//
//  Copyright (C) 2023 Tencent. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
//  except in compliance with the License. You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  unless required by applicable law or agreed to in writing, software distributed under the
//  license is distributed on an "as is" basis, without warranties or conditions of any kind,
//  either express or implied. see the license for the specific language governing permissions
//  and limitations under the license.
//
/////////////////////////////////////////////////////////////////////////////////////////////////

#include "base/utils/Verify.h"
#include "pag/file.h"

namespace pag {
CameraLayer::~CameraLayer() {
  delete cameraOption;
}

void CameraLayer::excludeVaryingRanges(std::vector<TimeRange>* timeRanges) {
  Layer::excludeVaryingRanges(timeRanges);
  cameraOption->excludeVaryingRanges(timeRanges);
}

bool CameraLayer::verify() const {
  if (!Layer::verify()) {
    VerifyFailed();
    return false;
  }
  VerifyAndReturn(cameraOption != nullptr && cameraOption->verify());
}

Rect CameraLayer::getBounds() const {
  return Rect::MakeWH(static_cast<float>(containingComposition->width),
                      static_cast<float>(containingComposition->height));
}
}  // namespace pag
