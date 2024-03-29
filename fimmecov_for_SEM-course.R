## 01/10/2021 Mod. 

##--
## gimmecov function
##
## Arguments:
## type:      'full' for full data in the covariance matrix, 
##            or 'half' for only one a triangle WITH diagonal values
## data:      (Optional) A vector with your row-wised written values 
##            including the diagonal. 
## cov.txt:   A .txt file with the values including the diagonal.
## nvars:     Number of variables 
## varnames:  (optional) A character string with the variable names
## names.txt: A .txt file including the variable names. (sep ="" as a
##            default, however you can change it)
## -- 

gimmecov <- function(type = c("full", "half"),
                     data = NULL, cov.txt, 
                     nvars, 
                     varnames = NULL, names.txt, sep = ""){
 if(type == "half"){
    if (is.null(data)) mat <- scan(file = cov.txt)
    else mat <- data
  
    triangular <- function(s) sapply(1:s, function(x) sum(1:x))
    triangular(nvars)
  
    diagmat <- mat[triangular(nvars)]
    uppermat <- mat[-triangular(nvars)]
  
    testm <- matrix(NA, ncol = nvars, nrow = nvars, byrow = TRUE)
    testm[upper.tri(testm)] <- uppermat
    testm[lower.tri(testm)] <- t(testm)[lower.tri(testm)]
    diag(testm) <- diagmat
 }
if(type == "full"){
    if (is.null(data)) mat <- scan(file = cov.txt)
    else mat <- data
    testm <- matrix(mat, ncol = nvars, nrow = nvars, byrow = TRUE)
}
  if (is.null(varnames)) 
    tmpnames <- scan(names.txt, what = "character", sep = sep)
  else tmpnames <- varnames  

  dimnames(testm) <- list(tmpnames, tmpnames)
  
  return(testm)
}



