require 'rakeutils/innotask'

describe InnoTask do

  context '#new' do

    it "raises an exception if Inno Setup is not installed" do
      InnoTask
        .any_instance
        .should_receive(:find_app)
        .twice
        .and_return ""

      expect { InnoTask.new }.to raise_error
    end

    it "doesn't raise an exception if Inno Setup is installed" do
      # Note: the file/directory has to exist or the ctor will fail anyway.
      InnoTask
        .any_instance
        .should_receive(:find_app)
        .twice
        .and_return "/tmp"

      expect { InnoTask.new }.not_to raise_error
    end

  end
end
