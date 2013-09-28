require 'tempfile'
require 'append_to_commit_message'
require 'bash_command'

describe "automatically appending a message to the git commit message file" do

	it "should work, dammit" do 
		temp_file = Tempfile.new "fake_git_commit_message"

		temp_file.write "Original commit message."
		temp_file.flush

		bash_command AppendToCommitMessage.create_script_command("[merged]", temp_file.path)

		File.open(temp_file.path, 'r').first.strip.should == "Original commit message. [merged]"
	end
	
end