# Force ExecJS to prefer Node.js runtime in production (avoid missing bun/other runtimes)
require "execjs"

if ExecJS::Runtimes.const_defined?(:Node)
  ExecJS.runtime = ExecJS::Runtimes::Node
end
