context("data preparation")

test_that("data preparation produces correct output", {
  data("Po_dA")
  data("Po_w")
  data("Po_s")
  data("Po_QWBM")
  
  bdpo <- bam_data(w = Po_w, s = Po_s, dA = Po_dA, Qhat = Po_QWBM)
  expect_is(bdpo, "bamdata")
  expect_is(bdpo$logW, "matrix")
  expect_is(bdpo$logS, "matrix")
  expect_is(bdpo$dA, "matrix")
  expect_is(bdpo$logQ_hat, "numeric")
  
  expect_equal(nrow(bdpo$logW), bdpo$nt)
  expect_equal(ncol(bdpo$logW), bdpo$nx)
  expect_equal(length(bdpo$logQ_hat), bdpo$nt)
  
  expect_is(bam_priors(bamdata = bdpo), "list")
  
  expect_is(compose_bam_inputs(bdpo, bam_priors(bdpo)), "list")

})


test_that("NA values are removed or replaced", {
  data("Po_dA")
  data("Po_w")
  data("Po_s")
  data("Po_QWBM")
  
  
  randna <- function(mat, n) {
    rws <- sample(1:nrow(mat), n)
    cls <- sample(1:ncol(mat), n)
    
    for (i in 1:n)
      mat[rws[i], cls[i]] <- NA
    mat
  }
  
  
  expect_message(bdpo <- bam_data(w = randna(Po_w, 3), 
                   s = randna(Po_s, 4), 
                   dA = randna(Po_dA, 5),
                   Qhat = Po_QWBM))
  
  expect_equal(sum(is.na(bdpo$logW)), 0)
  expect_equal(sum(is.na(bdpo$logS)), 0)
  expect_equal(sum(is.na(bdpo$dA)), 0)
  
  expect_equal(nrow(bdpo$logW), bdpo$nt)
  expect_equal(ncol(bdpo$logS), bdpo$nx)
})


test_that("Parameter estimation yields sensible values", {
  data("Po_dA")
  data("Po_w")
  data("Po_s")
  data("Po_QWBM")
  
  bdpo <- bam_data(w = Po_w, s = Po_s, dA = Po_dA, Qhat = Po_QWBM)
  prpo <- bam_priors(bdpo)
  
  
})