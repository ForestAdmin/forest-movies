class Forest::Comment
  include  ForestLiana::Collection

  collection :comments

  action 'Approve'
  action 'Disapprove'
end
