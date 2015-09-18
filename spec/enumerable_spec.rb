require 'rspec'
require_relative '../lib/enumerableAddIns'

describe 'my_each' do

  it 'mimics enumerable each' do
    array = [ 1, 2, 3, 4, 5, 6 ]
    double = Proc.new { | x | x = x * 2 }

    a = array.my_each( &double )
    b = array.each( &double )

    expect( a ).to eq( b )
  end

end

describe 'my_each_with_index' do 

  it 'mimics enumerable each_with_index' do
    array = [ 1, 2, 3, 4, 5, 6 ]
    double = Proc.new { | x, y | "#{ x } #{ y * 3 }"}
    
    a = array.my_each_with_index( &double )
    b = array.each_with_index( &double )
    
    expect( a ).to eq( b )
  end

end

describe 'my_select' do

  it 'mimics enumerable select' do
    array = [ 1, 2, 3, 4, 5, 6 ]
    double = Proc.new { | x | x % 2 == 0 }

    a = array.my_select( &double )
    b = array.select( &double )

    expect( a ).to eq( b )
  end

end

describe 'my_all?' do 

  it 'mimics enumerable all?' do 
    array = [ 2, 2, 4, 4, 6, 6 ]
    double = Proc.new { | x | x % 2 == 0 }
    
    a = array.my_all?( &double )
    b = array.all?( &double )

    expect( a ).to eq( b )
  end

end

describe 'my_any?' do 

  it 'mimics enumerable any in all true case' do 
    array = [ 2, 4, 6 ]
    double = Proc.new { | x | x % 2 == 0 }
    
    a = array.my_any?( &double  )
    b = array.any?( &double )

    expect( a ).to eq( b )
  end

  it 'mimics enumerable any in all false case' do 
    array = [ 1, 3, 5 ]
    double = Proc.new { | x | x % 2 == 0 }
    
    a = array.my_any?( &double  )
    b = array.any?( &double )

    expect( a ).to eq( b )
  end

  it 'mimics enumerable any in mixed case' do 
    array = [ 2, 2, 3, 4, 6, 6 ]
    double = Proc.new { | x | x % 2 == 0 }
    
    a = array.my_any?( &double  )
    b = array.any?( &double )

    expect( a ).to eq( b )
  end

end

describe 'my_none?' do 

  it 'mimics enumerable none in all true case?' do 
    array = [ 1, 3, 5 ]
    double = Proc.new { | x | x % 2 == 0 }
    
    a = array.my_none?( &double )
    b = array.none?( &double )

    expect( a ).to eq( b )
  end

  it 'mimics enumerable none in all false case?' do 
    array = [ 2, 4, 6 ]
    double = Proc.new { | x | x % 2 == 0 }
    
    a = array.my_none?( &double )
    b = array.none?( &double )

    expect( a ).to eq( b )
  end

  it 'mimics enumerable none in mixed case?' do 
    array = [ 2, 2, 3, 4, 6, 6 ]
    double = Proc.new { | x | x % 2 == 0 }
    
    a = array.my_none?( &double )
    b = array.none?( &double )

    expect( a ).to eq( b )
  end

end

describe 'my_count' do 

  it 'mimics enumerable count in all true case' do
    array = [ 2, 4, 6 ]
    double = Proc.new { | x | x % 2 == 0 }

    a = array.my_count( &double )
    b = array.count( &double )
    
    expect( a ).to eq( b )  
  end

  it 'mimics enumerable count in all false case' do
    array = [ 1, 3, 5 ]
    double = Proc.new { | x | x % 2 == 0 }

    a = array.my_count( &double )
    b = array.count( &double )
    
    expect( a ).to eq( b )  
  end

  it 'mimics enumerable count in all true case' do
    array = [2, 2, 3, 4, 6, 6]
    double = Proc.new { | x | x % 2 == 0 }

    a = array.my_count( &double )
    b = array.count( &double )
    
    expect( a ).to eq( b )
  end

end

describe 'my_map' do 

  it 'mimics enumerable map with a block' do 
    array = [ 1, 2, 3, 4 ]

    a = array.my_map { | y | y * 2 }
    b = array.map { | y | y * 2 }

    expect( a ).to eq( b )  
  end

  it 'mimics enumerable map with a proc' do 
    array = [ 1, 2, 3, 4 ]
    halfloat = Proc.new { | n | n.to_f / 2 }
    
    a = array.my_map( &halfloat )
    b = array.map( &halfloat )

    expect( a ).to eq( b )
  end

  it 'accepts both a proc and a block, and executes if both are supplied' do 
    array = [ 1, 2, 3, 4 ]
    halfloat = Proc.new { | n | n.to_f / 2 }

    a = array.my_map( halfloat ) { | y | y * 2 }
    b = [ 1.0, 2.0, 3.0, 4.0 ]

    expect( a ).to eq( array )  
  end

end

describe 'my_inject' do 

  it 'mimics enumerable inject' do
    array = [ 2, 4, 5 ]

    a = array.my_inject( 3 ) { | sum, n | sum * n }
    b = array.inject( 3 ){ | sum, n | sum * n }
    
    expect( a ).to eq( b )
  end

  it 'mimics enumerable inject' do
    array = [ 2, 4, 5 ]
    
    a = array.my_inject {|sum,n|sum*n}
    b = array.inject{|sum,n|sum*n}
    
    expect( a ).to eq( b )
  end

  it 'mimics enumerable inject' do
    array = [ 2, 4, 5 ]

    #symbol for multiply operator
    a = array.my_inject(2, :*)
    b = array.inject(2, :*)

    expect( a ).to eq( b )
  end

end

describe 'my_multiply_els' do 
  
  it 'multiplies elements of an array together using my_inject' do 
    array = [ 2, 4, 5 ]
    
    expect(multiply_els(array)).to eq(40)
  end

end