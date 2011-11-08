function passed = test_gp_test(hyperparameters, inference_method, ...
        mean_function, covariance_function, likelihood, data, ...
        responses, test_data, test_responses, number_of_runs)

  tic
  for i = 1:number_of_runs
    [gpml_ymu gpml_ys2 gpml_fmu gpml_fs2] = gp(hyperparameters, ...
            inference_method, mean_function, covariance_function, ...
            likelihood, data, responses, test_data, test_responses);
  end
  gpml_elapsed = toc;

  tic;
  for i = 1:number_of_runs
    [gp_test_ymu gp_test_ys2 gp_test_fmu gp_test_fs2] = ...
        gp_test(hyperparameters, inference_method, mean_function, ...
                covariance_function, likelihood, data, responses, ...
                test_data, test_responses);
  end
  gp_test_elapsed = toc;

  passed = all(gpml_ymu == gp_test_ymu) && ...
           all(gpml_ys2 == gp_test_ys2) && ...
           all(gpml_fmu == gp_test_fmu) && ...
           all(gpml_fs2 == gp_test_fs2);

  disp(['     gpml total time: ' num2str(gpml_elapsed) 's.']);
  disp(['   gpml average time: ' num2str(gpml_elapsed / number_of_runs) 's.']);

  disp(['  gp test total time: ' num2str(gp_test_elapsed) 's.']);
  disp(['gp test average time: ' num2str(gp_test_elapsed / number_of_runs) 's.']);

end