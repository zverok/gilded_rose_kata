real = `ruby texttest_fixture.rb 30`.split("\n")
expected = File.read('stdout.gr').split("\n")


expected.zip(real).each_with_index do |(e, r), i|
  next if e == r
  puts "#{i}:"
  puts "- #{e}"
  puts "+ #{r}"
end
