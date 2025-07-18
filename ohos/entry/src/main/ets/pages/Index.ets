/////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Tencent is pleased to support the open source community by making libpag available.
//
//  Copyright (C) 2024 Tencent. All rights reserved.
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

import * as pag from 'libpag';

@Entry
@Component
struct Index {
  @State imageViewControllers: Array<pag.PAGImageViewController> = new Array<pag.PAGImageViewController>();
  @State viewController: pag.PAGViewController = new pag.PAGViewController();
  @State pageIndex: number = 0;

  aboutToAppear(): void {
    let manager = getContext(this).resourceManager;
    let file = pag.PAGFile.LoadFromAssets(manager, "PAG_LOGO.pag");
    this.viewController.setComposition(file);
    this.viewController.setRepeatCount(-1);
    this.viewController.play();

    for (let index = 0; index < 20; index++) {
      let imageViewController = new pag.PAGImageViewController();
      let file = pag.PAGFile.LoadFromAssets(manager, "list/" + index + ".pag");
      imageViewController.setComposition(file);
      imageViewController.setRepeatCount(-1);
      this.imageViewControllers.push(imageViewController);
    }
  }

  build() {
    Column() {
      Row() {
        if (this.pageIndex == 1) {
          Grid() {
            ForEach(this.imageViewControllers, (item: pag.PAGImageViewController) => {
              GridItem() {
                pag.PAGImageView({
                  controller: item
                })
                  .onClick(() => {
                    if (item.isPlaying()) {
                      item.pause();
                    } else {
                      item.play();
                    }
                  })
              }.width("25%").height(100)
            })
          }.width("100%")
        } else {
          pag.PAGView({
            controller: this.viewController
          }).onClick(() => {
            if (this.viewController.isPlaying()) {
              this.viewController.pause();
            } else {
              this.viewController.play();
            }
          })
        }
      }.height("70%")


      Row() {
        Button("PAGView").width("40%").margin(10)
          .onClick(() => {
            this.pageIndex = 0;
            this.viewController.play();
            this.imageViewControllers.forEach((item: pag.PAGImageViewController) => {
              item.pause();
            })
          })

        Button("PAGImageView").width("40%")
          .onClick(() => {
            this.pageIndex = 1;
            this.imageViewControllers.forEach((item: pag.PAGImageViewController) => {
              item.play();
            })
            this.viewController.pause();
          })
      }

    }
  }
}
