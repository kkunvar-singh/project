class Education < ApplicationRecord

    validates :institude_name, :university, :course, :stream, :marks, :passed_year, :parsentage, presence: true
end
