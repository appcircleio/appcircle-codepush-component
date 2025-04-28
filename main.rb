require 'pathname'
require 'fileutils'

def get_env_variable(key)
  ENV[key].nil? || ENV[key] == '' ? nil : ENV[key]
end

def env_has_key(key)
  !ENV[key].nil? && ENV[key] != '' ? ENV[key] : abort("Missing #{key}.")
end

project_path = env_has_key('AC_REPOSITORY_DIR')
server_url = env_has_key('AC_CODE_PUSH_SERVER_URL')
auth_url = env_has_key('AC_CODE_PUSH_AUTH_URL')
access_token = env_has_key('AC_CODE_PUSH_TOKEN')
app_name = env_has_key('AC_CODE_PUSH_APP_NAME')
platform_type = %w[apk aab].include?(ENV['AC_OUTPUT_TYPE']&.downcase) ? 'android' : 'ios'
target_version = env_has_key('AC_CODE_PUSH_TARGET_BINARY_VERSION')
description = get_env_variable('AC_CODE_PUSH_DESCRIPTION')
deployment_name = get_env_variable('AC_CODE_PUSH_DEPLOYMENT_NAME')
rollout_percentage = get_env_variable('AC_CODE_PUSH_ROLLOUT_PERCENTAGE')
extra_arguments = get_env_variable('AC_CODE_PUSH_EXTRA_ARGUMENTS')


def run_command(cmd)
  puts "@@[command] #{cmd}"
  status = nil
  stdout_str = nil
  stderr_str = nil

  Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      stdout.each_line do |line|
          puts line
      end
      stdout_str = stdout.read
      stderr_str = stderr.read
      status = wait_thr.value
  end

  unless status.success?
      puts stderr_str
      raise stderr_str
  end
end


run_command("sudo npm install -g @appcircle/codepush-cli")

login_cmd = "appcircle-code-push login --accessKey #{access_token} --serverUrl #{server_url} --authUrl #{auth_url}"
run_command("#{login_cmd}")

cmd = "appcircle-code-push release-react #{app_name} #{platform_type} --deploymentName #{deployment_name} --targetBinaryVersion #{target_version}"
cmd += " --description '#{description}'" if description
cmd += " --rollout #{rollout_percentage}" if rollout_percentage
cmd += " #{extra_arguments}" if extra_arguments

Dir.chdir(project_path) do 
    run_command(cmd)
end