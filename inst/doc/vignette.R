## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
knitr::opts_chunk$set(echo = TRUE, fig.width = 7, fig.height = 7, fig.show = "hold")

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("PCAmatchR")

## ----eval=FALSE---------------------------------------------------------------
#  devtools::install_github("machiela-lab/PCAmatchR")

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("optmatch")

## ----eval=FALSE---------------------------------------------------------------
#  library(PCAmatchR)
#  library(optmatch)

## ----eval=TRUE, warning=FALSE, message=FALSE, cache=TRUE----------------------
# Load required packages
loadedPackages <- c("PCAmatchR", "optmatch")
invisible(lapply(loadedPackages, require, character.only = TRUE))

# Create PC data frame
pcs<- as.data.frame(PCs_1000G[,c(1,5:24)])

# Create eigenvalues vector
eigen_vals<- c(eigenvalues_1000G)$eigen_values

# Create full eigenvalues vector
all_eigen_vals<- c(eigenvalues_all_1000G)$eigen_values

## ----eval=TRUE----------------------------------------------------------------
covariate_data<- as.data.frame(PCs_1000G[,1:4])
covariate_data$case <- ifelse(covariate_data$pop=="ESN", c(1), c(0))

## ----eval=TRUE----------------------------------------------------------------
match_maker_output<- match_maker(PC = pcs,
                                 eigen_value = eigen_vals,
                                 data = covariate_data,
                                 ids = c("sample"),
                                 case_control="case",
                                 num_controls = 2,
                                 eigen_sum = sum(all_eigen_vals))

## ----eval=FALSE---------------------------------------------------------------
#  PCA_matches<- match_maker_output$matches
#  PCA_matches$match_distance

## ----eval=TRUE----------------------------------------------------------------
plot_maker(data=match_maker_output,
           x_var="PC1",
           y_var="PC2",
           case_control="case",
           line=F,
           xlim = c(0.025,0.04),
           ylim = c(-0.008,0.00))

## ----eval=TRUE----------------------------------------------------------------
plot_maker(data=match_maker_output,
           x_var="PC1",
           y_var="PC2",
           case_control="case",
           line=T,
           xlim = c(0.025,0.04),
           ylim = c(-0.008,0.00))

