require 'rakeutils/javacctask'

describe JavaCCTask do

  def stub_javacc
    path = "/home/jeff/bin"
    app_path = File.join(path, "javacc")

    FileUtils.mkdir_p path
    File.open(app_path, "w") do |f|
      f.puts "#!/usr/bin/env bash"
      f.puts "echo JavaCC"
      f.fsync
    end
    FileUtils.chmod(0755, app_path, :verbose => true)

    while ! File.exist? app_path
      # nop
      put "*"
    end
  end

  def remove_stub_javacc
    path = "/home/jeff/bin"
    app_path = File.join(path, "javacc")

    if File.exist? app_path
      FileUtils.rm app_path
    end

    while File.exist? app_path
      # nop
      put "*"
    end
  end

  context '#new' do

    it "raises an exception if JavaCC is not installed" do
      JavaCCTask
        .any_instance
        .should_receive(:find_app)
        .twice
        .and_return ""

      expect { JavaCCTask.new }.to raise_error
    end

    it "doesn't raise an exception if JavaCC is installed" do
      JavaCCTask
        .any_instance
        .should_receive(:find_app)
        .twice
        .and_return "/tmp"
      #stub_javacc

      expect { JavaCCTask.new }.not_to raise_error

      remove_stub_javacc
    end

  end
end
