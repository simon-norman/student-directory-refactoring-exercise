class Student
  attr_reader :first_name, :surname, :cohort, :birthplace
  COHORTS = [
    :Jan,
    :Feb,
    :Mar,
    :Nov,
    :Dec
  ]

  def initialize(first_name: '--', surname: '--', cohort: :unknown, birthplace: '--')
    @first_name = first_name
    @surname = surname
    @cohort = try_to_identify_cohort(cohort)
    @birthplace = birthplace
  end

  def try_to_identify_cohort(cohort)
    matched_cohort = COHORTS.find { |valid_cohort| valid_cohort.downcase == cohort[0..2].downcase.to_sym}
    
    matched_cohort || :unknown
  end
end
