class Forest::Comment
  include  ForestLiana::Collection

  collection :Comment

  action 'Approve'
  action 'Disapprove'
end
