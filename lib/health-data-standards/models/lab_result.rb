class LabResult < Entry
  field :referenceRangeHigh, as: :reference_range_high, type: String
  field :referenceRangeLow, as: :reference_range_low, type: String
  field :interpretation, type: Hash  
  field :reaction,   type: Hash
  field :method,  type: Hash
  
end