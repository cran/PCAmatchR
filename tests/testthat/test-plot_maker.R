context("plot_maker")

 ##### Input match_maker sample data to be used in test_that

 # Create PC data frame
 pcs<- as.data.frame(PCs_1000G[,c(1,5:24)])

 # Create eigenvalues vector
 eigen_vals<- c(eigenvalues_1000G)$eigen_values

 # Create full eigenvalues vector
 all_eigen_vals<- c(eigenvalues_all_1000G)$eigen_values

 # Create Covarite data frame
 cov_data<- PCs_1000G[,c(1:4)]

 # Generate a case status variable
 cov_data$case <- ifelse(cov_data$pop=="ESN", c(1), c(0))

 if(requireNamespace("optmatch", quietly = TRUE)){

 library(optmatch)

 # Generate match_maker_output
 match_maker_output<- match_maker(PC = pcs,
                                  eigen_value = eigen_vals,
                                  data = cov_data,
                                  ids = c("sample"),
                                  case_control="case",
                                  num_controls = 1,
                                  eigen_sum = sum(all_eigen_vals))

test_that("plot_maker throws error with invalid arguments", {

  expect_error(plot_maker(data=NULL,
                          x_var="PC1",
                          y_var="PC2",
                          case_control="case",
                          line=T)
  )
  expect_error(plot_maker(data=match_maker_output,
                          x_var=NULL,
                          y_var="PC2",
                          case_control="case",
                          line=T)
  )
  expect_error(plot_maker(data=match_maker_output,
                          x_var="PC1",
                          y_var=NULL,
                          case_control="case",
                          line=T)
  )
  expect_error(plot_maker(data=match_maker_output,
                          x_var="PC1",
                          y_var="PC2",
                          case_control=NULL,
                          line=T)
  )

 }
)

test_that("plot_maker works", {
  skip_on_cran()
  expect_output(plot_maker(data=match_maker_output,
                           x_var="PC1",
                           y_var="PC2",
                           case_control="case",
                           line=T),
               NA)

 }
)

}
