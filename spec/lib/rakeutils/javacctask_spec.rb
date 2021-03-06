require 'rakeutils/javacctask'

describe JavaCCTask do

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
      # Note: the file/directory has to exist or the ctor will fail anyway.
      JavaCCTask
        .any_instance
        .should_receive(:find_app)
        .twice
        .and_return "/tmp"

      expect { JavaCCTask.new }.not_to raise_error
    end

  end
end
