require 'test/unit'
require 'test/unit/testcase'

[ './../lib/', './lib/' ].each do |lib_dir|
  lib_dir = File.expand_path(lib_dir)
  if File.exists?(lib_dir) && !$LOAD_PATH.include?(lib_dir)
    $LOAD_PATH << lib_dir
  end
end
