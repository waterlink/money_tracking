# FIXME: remove it, once there is some real store
class DummyStore
  def create(record)
    `touch created_some`
    "7dt0ibnv"
  end

  def read(id)
    {
      id: id,
      created_at: "17-04-2015 19:04:34",
      amount: "99.89",
      currency: "euro",
      tags: ["food"],
    }
  end

  def list
    return [] unless File.exist?("created_some")
    amount = "73.90"
    amount = File.read("changed_amount").strip if File.exist?("changed_amount")
    [{
       id: "7dt0ibnv",
       created_at: "17-04-2015 19:04:34",
       amount: amount,
       currency: "euro",
       tags: ["food"],
     }]
  end

  def update(id, fields)
    `echo #{fields[:amount]} > changed_amount`
  end

  def delete(id)
    `rm created_some`
  end
end
