## Function for specifying the residual covariances 
# that are constrained to equality.
## Based on Shoemann & Jorgensen, 2021 (https://doi.org/10.3390/psych3030024).
## 24-1-2022

eqResCovFun <-  function(x1, x2) {
  tog <- expand.grid(x1, x2)
  tognames <- c()
  res <- matrix(0, nrow = nrow(tog), ncol = nrow(tog))
  for (i in 1:nrow(tog)) {
    for (j in 1:nrow(tog)) {
      if (tog[j, 1] == tog[i, 1] && tog[j, 2] == tog[i, 2]) {
        res[i, j] <- ''
      }
      if (tog[j, 1] == tog[i, 1] && tog[j, 2] != tog[i, 2]) {
        res[i, j] <- as.character(tog[j, 1])
      }
      if (tog[j, 1] != tog[i, 1] && tog[j, 2] == tog[i, 2]) {
        res[i, j] <- as.character(tog[j, 2])
      }
    }
    tognames[i] <- paste0(tog[i, 1], tog[i, 2])

  }
  dimnames(res) <- list(tognames, tognames)
  res[upper.tri(res)] <- NA
  
  ## String part
  str2 <- str1 <- ""
  for (k in 1:nrow(res)) {
    if (k < nrow(res)) {
      str2 <-
        paste(res[(k + 1):nrow(res), k], '*', tognames[(k + 1):nrow(res)])
      str2 <- paste(tognames[k], '~~', str2, collapse = '\n')
      str1 <- paste(str1, str2, sep = '\n')
    }
    
  }
  return(list(
    Matrix = res, # which covs need to be constrained?
    ProductNames = tognames,
    String = str1 # the string to combine with the rest lavaan-type specified model
  ))
}

## Names of the variables
## tvalue = Teacher's perceived value of testing
## sources = sources of teacher stress
tvalue <- paste0("t", 1:4)
sources <- paste0("s", 1:5)

## Test the function
out <- eqResCovFun(tvalue, sources)
cat(out$String)
