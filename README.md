# Drone wait plugin

Can be useful when working on matrix builds

## Provide job

Should be enabled on the matrix branch providing the file

```yaml
matrix:
  MATRIX_ENV:
    - provider
    - job1
    - job2
    
pipeline:

  provide-file:
    image: gboo/drone-wait-file
    mode: provide
    source: file.ext
    target: /cache/${DRONE_BUILD_NUMBER}-file.ext
    when:
      status: [ success, failure ]
      matrix:
        MATRIX_ENV: provide
    volume:
      /cache:/cache
      
      
  get-file:
    image: gboo/drone-wait-file
    mode: wait
    target: /cache/${DRONE_BUILD_NUMBER}-file.ext
    when:
      matrix:
        MATRIX_ENV: [ job1, job2 ]
    volume:
      /cache:/cache
      
```


# WARNING

Don't forget to also run the `provide` on failure event, otherwise child jobs cannot fail.
