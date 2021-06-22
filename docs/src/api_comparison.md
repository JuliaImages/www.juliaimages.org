# [Comparison with other image processing frameworks](@id page_api_comparison)

The following table may be useful for people migrating from other
frameworks, and for identifying missing functionality in
JuliaImages. Note that there are relevant packages which have not been
integrated into more general frameworks or hosted at JuliaImages
(e.g., `DICOM.jl`, etc.); such functionality is not documented here.
This table is certainly not complete, and additions/corrections are
welcome.

| Operation                             | JuliaImages                               | scikit-image + NumPy              | Matlab (ImageProcessing + ComputerVision) |
| :------------------------------------ | :---------------------------------------- | :-------------------------------- | :---------------------------------------- |
| **Input/output**                      |                                           |                                   |                                           |
| Read image file                       | [`load`](@ref)                            | `imread`                          | `imread`                                  |
| Write image file                      | [`save`](@ref)                            | `imsave`                          | `imwrite`                                 |
| Image file metadata                   | `magickinfo` (ImageMagick.jl)             |                                   | `imfinfo`                                 |
| Test images                           | [`testimage`](@ref)                       | `astronaut` etc.                  | “cameraman.tif” etc                       |
|                                       |                                           |                                   |                                           |
| **Element type and color**            |                                           |                                   |                                           |
| Change numeric precision              | [`float32`](@ref), [`float64`](@ref), [`n0f8`](@ref), etc. | `img_as_float` etc  | `im2double` etc                        |
| Change color space                    | `HSV.(img)` etc.                          | `rgb2hsv` etc.                    | `rgb2lab` etc.                            |
| Whitepoint adjustment                 | map `whitebalance` (Colors.jl)            |                                   | `makecform`                               |
| High dynamic range                    |                                           |                                   | `tonemap`                                 |
|                                       |                                           |                                   |                                           |
| **Intensity & quantization**          |                                           |                                   |                                           |
| Clamping                              | [`clamp01`](@ref), [`clamp01nan`](@ref)   |                                   |                                           |
| Linear scaling                        | [`LinearStretching`](@ref), [`scaleminmax`](@ref), etc.  | `rescale_intensity`| `imadjust`                                |
| Nonlinear scaling                     | [`GammaCorrection`](@ref)                 | `adjust_gamma`                    | `imadjust`                                |
| Compute histogram                     | [`build_histogram`](@ref)                 | `histogram`                       | `imhist`                                  |
| Histogram equalization                | [`Equalization`](@ref)                    | `equalize_hist`                   | `histeq`                                  |
| Adaptive equalization                 | [`AdaptiveEqualization`](@ref)            | `equalize_adapthist`              | `adapthisteq`                             |
| Reference histogram matching          | [`Matching`](@ref)                        | `match_histograms`                | `imhistmatch`                             |
| Quantization                          | map anonymous function                    |                                   | `imquantize`                              |
| Threshold estimation                  | [`Otsu`](@ref) etc. (HistogramThresholding.jl) | `threshold_otsu` etc.             | `graythresh` etc.                         |
|                                       |                                           |                                   |                                           |
| **Visualization and interactivity**   |                                           |                                   |                                           |
| Visualization                         | `imshow` (ImageView.jl), [`mosaicview`](@ref) | `imshow`                      | `imshow`, `implay`, `montage`, etc.       |
| Contrast adjustment                   | ImageView.jl                              |                                   | `imcontrast`                              |
| Pixel information                     | ImageView.jl                              |                                   | `impixelinfo`                             |
| Distance measurement                  |                                           |                                   | `imdistline`                              |
| Text display of region                |                                           |                                   | `impixelregion`                           |
| Zooming/scrolling                     | ImageView.jl and GtkUtilities.jl          | `imshow`                          | `imscrollpanel` etc.                      |
| Interactive colormap                  |                                           |                                   | `imcolormaptool`                          |
| Region selection                      |                                           | `RecatangleTool` etc.             | `imrect`, `imellipse`, `imfreehand`, etc. |
| Image comparison                      | [`colorview`](@ref), [`mosaicview`](@ref) |                                   | `imshowpair`, `imfuse`                    |
| Label colorization                    | `IndirectArray`, `ColorizedArray`         | `label2rgb`                       | `label2rgb`                               |
|                                       |                                           |                                   |                                           |
| **Annotation**                        |                                           |                                   |                                           |
| Draw lines                            | `line`, `line!` (ImageDraw.jl)            | `line`, `polygon`                 | `line` (visualization only)               |
| Draw circles/ellipses                 | `circle!`, `ellipse!` (ImageDraw.jl)      | `circle`, `ellipse`               | `viscircles` (visualization only)         |
|                                       |                                           |                                   |                                           |
| **Transformations**                   |                                           |                                   |                                           |
| Resize                                | [`imresize`](@ref), [`restrict`](@ref)    | `resize`                          | `imresize`                                |
| Image pyramids                        | [`gaussian_pyramid`](@ref), [`restrict`](@ref) | `pyramid_gaussian` etc.      | `impyramid`                               |
| Rotate                                | [`imrotate`](@ref)                        | `rotate`                          | `imrotate`                                |
| Translate                             | [`warp`](@ref)                            |                                   | `imtranslate`                             |
| General geometric transformation      | [`warp`](@ref)                            | `warp`                            | `imwarp`                                  |
| Hough transform                       | [`hough_transform_standard`](@ref), [`hough_circle_gradient`](@ref) | `hough_circle`, etc.  | `hough`                     |
| Radon transform                       |                                           | `radon`, `iradon`                 | `radon`, `iradon`                         |
| Distance transform                    | [`feature_transform`](@ref), [`distance_transform`](@ref) |                   | `bwdist`, `graydist`                      |
|                                       |                                           |                                   |                                           |
| **Registration**                      |                                           |                                   |                                           |
|                                       |                                           |                                   |                                           |
| **Statistics and image comparison**   |                                           |                                   |                                           |
| Image differences                     | `ssd`, `sad`, `mse`, `rmse` etc.          | `compare_mse`, `compare_nrmse`    | `immse`           |
| Min/max/mean                          | [`minfinite`](@ref), [`maxfinite`](@ref), [`meanfinite`](@ref)    | `minimum`, `maximum`, `mean`      | `nanmax`, etc.    |
| Entropy                               | [`entropy`](@ref)                         | `entropy`                         | `entropy`                                 |
| quality assessment                    | [`PSNR`](@ref), [`SSIM`](@ref)            | `compare_psnr`, `compare_ssim`    | `psnr`, `ssim`                        |
| colorfulness                          | [`colorfulness`](@ref)                    |                                   |                                           |
|                                       |                                           |                                   |                                           |
| **Filtering and padding**             |                                           |                                   |                                           |
| Linear filtering                      | [`imfilter`](@ref)                        | `gaussian`, etc.                  | `imfilter`                                |
| Median/max/quantile filtering         | [`mapwindow`](@ref)                       | `median`/`max` etc.               | `nlfilter`, `medfilt2`, etc.              |
| Other nonlinear filtering (e.g., std) | [`mapwindow`](@ref)                       |                                   | `nlfilter`, `stdfilt`                     |
| Gradients                             | [`imgradients`](@ref)                     | `sobel_h` etc.                    | `imgradientxy` etc.                       |
| Integral image                        | [`integral_image`](@ref)                  | `integral_image`                  | `integralImage`                           |
| Padding                               | [`padarray`](@ref)                        | `pad`                             | `padarray`                                |
| Deconvolution                         | `wiener` (Deconvolution.jl)               | `richardson_lucy`, `weiner`, etc. | `deconvlucy`, `deconvwnr`, etc.           |
|                                       |                                           |                                   |                                           |
| **Features**                          |                                           |                                   |                                           |
| Edge detection                        | [`imedge`](@ref), [`canny`](@ref)         | `canny`                           | `edge`                                    |
| Corner detection                      | [`imcorner`](@ref), [`fastcorners`](@ref) | `corner_harris` etc.              | `detectFASTFeatures`                      |
| Blob detection                        | [`blob_LoG`](@ref)                        | `blob_log` etc.                   |                                           |
| Local binary patterns                 | `lbp` etc. (ImageFeatures.jl)             | `local_binary_pattern`            | `extractLBPFeatures`                      |
| Histogram of oriented gradients       | `HOG` (ImageFeatures.jl)                  | `hog`                             | `extractHOGFeatures`                      |
| Gray-level co-occurence               | `glcm` etc. (ImageFeatures.jl)            | `greycomatrix`                    | `graycomatrix`                            |
| Point descriptors                     | `BRIEF`, `ORB`, etc. (ImageFeatures.jl)   | `BRIEF`, `ORB`, etc.              | `detectBRISK` etc.                        |
| Feature matching                      | `match_keypoints` (ImageFeatures.jl)      | `match_descriptors`               | `matchFeatures`                           |
|                                       |                                           |                                   |                                           |
| **Segmentation**                      |                                           |                                   |                                           |
| Connected components                  | [`label_components`](@ref)                | `label`                           | `bwconncomp`, `bwlabel`                   |
| Foreground/background                 |                                           | `active_contour`                  | `activecontour`                           |
| Clustering                            | `kmeans`, `fuzzy_cmeans`, `mean_shift` (Clustering.jl) | `quickshift`, `slic` |                                           |
| Marker segmentation                   | [`seeded_region_growing`](@ref)           | `random_walker`                   | `imsegfmm`                                |
| Watershed                             | [`watershed`](@ref)                       | `watershed`                       | `watershed`                               |
|                                       |                                           |                                   |                                           |
| **Morphological operations**          |                                           |                                   |                                           |
| Dilation                              | [`dilate`](@ref)                          | `dilation`, `binary_dilation`     | `imdilate`                                |
| Erosion                               | [`erode`](@ref)                           |                                   |                                           |
| Opening                               | [`opening`](@ref)                         | `opening`                         | `imopen`                                  |
| Closing                               | [`closing`](@ref)                         | `closing`                         | `imclose`                                 |
| Top-hat filtering                     | [`tophat`](@ref)                          | `tophat` etc.                     | `imtophat`                                |
| Bottom-hat filtering                  | [`bothat`](@ref)                          | `bottomhat`                       | `imbothat`                                |
| Regional max/min                      | [`mapwindow`](@ref)                       | `filters.rank.maximum` etc.       | `imregionalmax` etc.                      |
| Convex hull                           | [`convexhull`](@ref)                      | `convex_hull_image`               | `bwconvhull`                              |
| Borders                               | `clearborder`                             | `clear_border`                    | `imclearborder`                           |
| Boundaries                            |                                           | `find_boundaries`                 | `boundarymask`                            |
| Filling                               | `imfill`                                  | `remove_small_holes`              | `imfill`, `regionfill`                    |
