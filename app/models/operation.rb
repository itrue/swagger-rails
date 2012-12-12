class Operation < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :api
  has_many :parameters, :dependent => :destroy
  accepts_nested_attributes_for :parameters, :allow_destroy => true
  validates_presence_of :api_id
  validates_presence_of :http_method
  HTTP_METHODS = [:GET, :POST, :PUT, :DELETE]

  def to_json
    {
      :httpMethod => http_method,
      :nickname => nickname,
      :responseClass => response_class,
      :summary => summary,
      :notes => note,
      :parameters => parameters.map{ |parameter| parameter.to_json },
      :errorResponses => []
    }
  end
end