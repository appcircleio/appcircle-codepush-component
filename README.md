# Appcircle Codepush Component

Appcircle CodePush Component lets you deliver over-the-air updates to your React Native apps through a single step in your CI/CD pipeline.

## Required Inputs

- `AC_REPOSITORY_DIR`: Relative path of the React Native project.
- `AC_CODE_PUSH_TOKEN`: Appcircle personal access token. You can create a new token in the Appcircle dashboard under `Settings > Security > Personal Access Token`.
- `AC_CODE_PUSH_APP_NAME`: This parameter specifies the name of the app in Appcircle. For example `MyApp-Android` or `MyApp-iOS`.
- `AC_CODE_PUSH_DEPLOYMENT_NAME`: This parameter specifies which deployment you want to release the update to. For example `Staging`.
- `AC_CODE_PUSH_TARGET_BINARY_VERSION`: This parameter specifies the target binary version of the app that this update is intended for. It should be in the format `1.0.0`.

## Optional Inputs

- `AC_CODE_PUSH_DESCRIPTION`: This parameter provides an optional change log for the deployment.
- `AC_CODE_PUSH_ROLLOUT_PERCENTAGE`: This parameter specifies the percentage of users (as an integer between 1 and 100) that should be eligible to receive this update.
- `AC_CODE_PUSH_EXTRA_ARGUMENTS`: Extra command line arguments for Appcircle. For example, add `--debug` for verbose logs.