#' @title DSGE model based on Smets Wouters (2003)
#' 
#' @details Some changes have been made to the capital and goods market 
#'     equilibrium conditions:
#'         (1) Capital market is now written as: 
#'             K[] = (1 - tau) * K[-1] + tau * I[].
#'         (2) The goods market is now written as:
#'             Y_P[] = (1 - tau * k_Y - g_Y) * C[] + tau * k_Y * I[] +
#'                 g_Y * epsilon_G[] + k_Y * r_k_bar * r_k[] * psi.
#'                 
#' @import gEcon


calculateDSGEModel <- function () {
  sw_gecon <- make_model(
    filename = getwd() %>%
      paste0("/models/DSGE_model.gcn"))
  
  # Set the initial parameters
  initv <- list(
    z = 1, z_f = 1, Q = 1, Q_f = 1, pi = 1,
    pi_obj = 1, epsilon_b = 1, epsilon_L = 1, 
    epsilon_I = 1, epsilon_a = 1, epsilon_G = 1,
    r_k = 0.01, r_k_f = 0.01)
  
  # Set the shock distribution parameters
  variances <- c(
    eta_b = 0.336 ^ 2, eta_L = 3.52 ^ 2, eta_I = 0.085 ^ 2, 
    eta_a = 0.598 ^ 2, eta_w = 0.6853261 ^ 2, eta_p = 0.7896512 ^ 2,
    eta_G = 0.325 ^ 2, eta_R = 0.081 ^ 2, eta_pi = 0.017 ^ 2)
  
  # Perform shock analysis
  DSGEModel %<>% initval_var(init_var = initv) %>%
    steady_state() %>%
    solve_pert(loglin = TRUE) %>%
    set_shock_cov_mat(
      cov_matrix = diag(variances),
      shock_order = names(variances)) %>%
    compute_model_stats() %>%
    compute_irf(
      variables = c("C", "Y", "K", "I", "L"),
      chol = TRUE, 
      shocks = c("eta_a", "eta_R"), 
      sim_length = 25) %>%
    plot_simulation(to_eps = TRUE)
  
  return(DSGEModel)
}
