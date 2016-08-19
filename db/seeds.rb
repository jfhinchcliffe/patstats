# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Note: mode 1 is a tram, mode 2 is a bus
Stop.create([
  { routes_serviced: '19', stop_name: '15-Leonard St/Royal Pde (Parkville)', operator: 'Yarra Trams', diva_id: 2816 , mode: 1, currently_checked: true },
  { routes_serviced: '59', stop_name: '39-Hoddle St/Fletcher St (Essendon)', operator: 'Yarra Trams', diva_id: 2676 , mode: 1, currently_checked: true },
  { routes_serviced: '96', stop_name: '133-Canterbury Rd/Fitzroy St (St Kilda)', operator: 'Yarra Trams', diva_id: 2884 , mode: 1, currently_checked: true },
  { routes_serviced: '75', stop_name: '11-Clarendon St/Wellington Pde (East Melbourne)', operator: 'Yarra Trams', diva_id: 2825 , mode: 1, currently_checked: true },
  { routes_serviced: '246', stop_name: 'Victoria Pde/Hoddle St (Richmond)', operator: 'Transdev', diva_id: 12405 , mode: 2, currently_checked: true },
  { routes_serviced: '900, 623, 624, 626, 822', stop_name: 'Wilson St/Dandenong Rd (Murrumbeena)', operator: 'CDC, Ventura, CDC Eastrans, ', diva_id: 13091 , mode: 2, currently_checked: true },
  { routes_serviced: '153', stop_name: 'Wattle Ave/Princes Hwy (Werribee)', operator: 'CDC Melbourne', diva_id: 10677 , mode: 2, currently_checked: true },
  { routes_serviced: '411', stop_name: 'South Ave/Victoria St (Altona Meadows)', operator: 'CDC Altona', diva_id: 15320 , mode: 2, currently_checked: true },
  ])