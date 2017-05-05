if Code.ensure_loaded?(Mix.Tasks.Firmware.Push) do

  defmodule Mix.Tasks.CloneOS.Upload do
    @moduledoc false
    use Mix.Task
    alias Mix.Tasks.Firmware.Push
    @shortdoc "Uploads a file to a url"
    def run([ipaddr | rest]) do
      otp_app = Mix.Project.config[:app]
      target = Mix.Project.config[:target]
      fw_file = if Enum.find(rest, fn(flag) ->
        flag == "--signed"
      end) do
        Mix.shell.info "Using signed image"
        Path.join(["images", "#{Mix.env()}", "#{target}", "#{otp_app}-signed.fw"])
      else
        Mix.shell.info "Using unsigned image"
        Path.join(["images", "#{Mix.env()}", "#{target}", "#{otp_app}.fw"])
      end
      Push.run([ipaddr, "--firmware", "#{fw_file}", "--reboot", "true"])
    end
  end

else

  defmodule Mix.Tasks.CloneOS.Upload do
    @moduledoc false
    use Mix.Task
    @shortdoc "Uploads a file to a url"
    def run(_) do
      Mix.raise """
      Something in your environment is borked!
      """
    end
  end

end
