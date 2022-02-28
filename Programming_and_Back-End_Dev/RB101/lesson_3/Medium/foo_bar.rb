def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

bar(foo)

# evaluates foo first
# foo is always "yes"
# bar("yes") evaluates to "no"
