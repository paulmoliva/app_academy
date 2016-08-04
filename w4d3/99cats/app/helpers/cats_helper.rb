module CatsHelper
  def get_requestors
    return @cat_requestors unless @cat_requestors.nil?

    @cat_requestors = Hash.new
    @cat.requestors.each do |r|
      @cat_requestors[r.id] = r.username
    end
    @cat_requestors
  end

  def get_requestor(req)
    get_requestors[req.user_id]
  end
end
