# Check for mismatched deployment labels in deployment data and image data

This function is mainly called for its messaging - alerting you to
deployment labels that are in the sample deployment data but not in the
image data, and vice versa.

## Usage

``` r
qa_deployment_images(deployments, image_data)
```

## Arguments

- deployments:

  deployments data, as created by
  [`make_deployments()`](https://bcgov.github.io/bccamtrap/reference/make_deployments.md)

- image_data:

  data.frame of class `image_data`, as read in by
  [`read_image_data()`](https://bcgov.github.io/bccamtrap/reference/read_image_data.md).

## Value

a list of two vectors containing mismatched deployment labels
