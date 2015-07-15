require 'rakeutils/jjtreetask'

describe JJTreeTask do

  context '#new' do

    it "raises an exception if JJTree is not installed" do
      JJTreeTask
        .any_instance
        .should_receive(:find_app)
        .twice
        .and_return ""

      expect { JJTreeTask.new }.to raise_error
    end

    it "doesn't raise an exception if JJTree is installed" do
      # Note: the file/directory has to exist or the ctor will fail anyway.
      JJTreeTask
        .any_instance
        .should_receive(:find_app)
        .twice
        .and_return "/tmp"

      expect { JJTreeTask.new }.not_to raise_error
    end

  end
end
