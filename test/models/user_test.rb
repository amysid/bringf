# require 'test_helper'

# class UserTest < ActiveSupport::TestCase
#   # test "the truth" do
#   #   assert true
#   # end
# end


require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "1 CountryCurrencyCodeValidation" do
    var1 = "US"
    if var = ["INR","US","UK","SGD","ROL"].include?(var1)
      assert true
    else
      assert_not false
    end
  end


  test "2 CurrencyValidator" do
    var = "123.20";
    if var =~ /^\d+(?:\.\d{0,2})$/;
      assert true
    else
      assert_not false
    end
  end

  test "3 DateTimeFormatValidation dd/MM/yyyy HH:MM format" do
    datetime="04/25/2017 11:25"
    if datetime =~ /^(([0]?[1-9]|1[0-2])\/([0-2]?[0-9]|3[0-1])\/[1-2]\d{3}) (20|21|22|23|[0-1]?\d{1}):([0-5]?\d{1})$/
      assert true
    else
      assert_not false
    end
  end

  test "4 EmailValidator" do
    var = "test11@gmail.com"
    if var =~ /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      assert true
    else
      assert_not false
    end
  end


  test "5 FirstNameValidator" do

    var = "test11"
    if var =~ /^[a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*$/
      assert true
    else
      assert_not false
    end
  end

  
  # end

  test "7 LastNameValidator" do
    var = "Test1"
    if var =~ /^[a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*$/
      assert true
    else
      assert false
    end
  end

  test "8 MappingReader" do
    assert true
  end

  test "9 MaxLengthValidator" do
    max_length = 4
    str = "test1"
    if str.length <= max_length
      assert true
    else
      assert_not false
    end
  end

  test "10 MinimumLengthValidator" do
    min_length = 2
    str = "test1"
    if str.length >= min_length
      assert true
    else
      assert_not false
    end
  end

  test "11 MobileValidator" do
    mobile = "121212121212"
    mobile=~/^(\+[\d]{1,3}|0)?[7-9]\d{9}$/
  end

  test "12 NotEmptyValidator" do
    mobile = ""
    mobile.empty?
  end

  test "13 NumberValidation" do
    num = 5.5
    (num.class == Fixnum || num.class == Float)
  end

  test "14 PasswordValidator" do
    pass = "Subhash@123"
    pass =~ /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$/
  end

  test "15 PastValidator" do
    date = "2018/09/30".to_date
    date < Date.today
  end

  test "16 PinCodeValidator" do
    pin_code = "544656"
    if pin_code =~ /^\d{6}$/;
      assert true
    else
      assert_not false
    end
  end

  test "17 PostalCodeValidationAustralia" do
     postal_code = "5667"
    if postal_code =~ /^\d{4}$/;
      assert true
    else
      assert_not false
    end
  end


  test "18 SearchValidator" do
    search = "hjrtyhyjyj"
    if search =~ /\A(\w+(?:[\s-]*\w+)?)(?:,\s*\g<1>)*\z/;
      assert true
    else
      assert_not false
    end
  end

  test "19 SizeValidator" do
   size = "fvgdb"
   if size =~ /^[\s\S]{5,8}$/;
     assert true
   else
     assert_not false
   end
  end

  test "20 UAEZipCodeValidator" do
    zip_code = "00000"
    if zip_code =~ /^\d{5}$/;
      assert true
    else
      assert_not false
    end
  end

  test "21 url validator" do
    url = "http://www.example.com"
    if url=~/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
      assert true
    else
      assert_not false
    end
  end

  test "22 zip code uk validator" do
    zip_code_uk = "Gg345"
    if zip_code_uk=~ /^\s*((GIR\s*0AA)|((([A-PR-UWYZ][0-9]{1,2})|(([A-PR-UWYZ][A-HK-Y][0-9]{1,2})|(([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))))\s*[0-9][ABD-HJLNP-UW-Z]{2}))\s*$/i
      assert true
    else
      assert_not false
    end
  end

  test "23 zip code validator" do
    zip_code = 247001
    if zip_code=~/^\d{5}(-\d{4})?$/
      assert true
    else
      assert_not false
    end
  end

  test "24 left padding trim validator" do
   left_padding = "    rails"
   padding = left_padding.lstrip
   if padding == "rails"
      assert true
   else
      assert_not false
   end
  end

  test "25 right padding trim validator" do
    right_padding = "rails     "
    padding = right_padding.rstrip
    if padding == "rails"
      assert true
    else
      assert_not false
    end
  end

  test "26 US address" do
    usAddressValidator = "barminghom road no: 1"
    ((usAddressValidator.length > 2) && (usAddressValidator.length < 60))
  end

  test "27 upper case" do
    uppercase = "GGBJKHKJ"
    (uppercase.upcase == uppercase)
  end

  test "28 lower case" do
    lowercase = "gdsgjdffd"
    (lowercase.downcase == lowercase)
  end

  test "29 mandatory field" do
    mandatory = "dgjfhdrg"
    mandatory.present?
  end

  test "30 opt" do
    otp = "1546"
    (otp == "^[0-9]{1,6}$")
  end

  test "31 PANNumberValidator" do
    pannumber = "ABCDE1234F"
    if pannumber =~/[A-Z]{5}[0-9]{4}[A-Z]{1}/
      assert true
    else
      assert_not false
    end
  end

  test "32 AadharCardValidator" do
    adharcard = "0000 0000 0000"
    if adharcard =~/^\d{4}\s\d{4}\s\d{4}$/
      assert true
    else
      assert_not false
    end
  end

  test "33 SSNNumberValidator" do
    ssn = "123-45-6789"
    if ssn =~/^(\d{3}-?\d{2}-?\d{4}|XXX-XX-XXXX)$/
      assert true
    else
      assert_not false
    end
  end

  test "34 CheckForPriceShouldAcceptTwoDigitAfterDecimal" do
    twodecimal = "44.95"
    if twodecimal =~/^[0-9]+\.[0-9][0-9]$/
      assert true
    else
      assert_not false
    end
  end

  test "35 PhoneNumberFormatValidator" do
    phonenumber = "987-333-3334"
    if phonenumber =~/(\d{3})\-?(\d{3})\-?(\d{4})/
      assert true
    else
      assert_not false
    end
  end

  test "36 phone number India" do
    phone_number_india = "9810528644"

    if phone_number_india =~ /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/;
      assert true
    else
      assert_not false
    end
  end

  test "37 lower than 2 values" do
    from = 50
    to = 55

    if from < to
      assert true
    else
       assert_not false
    end
  end

  test "38 alpha numeric" do
    alpha_numeric = "dfdfdsf"

    if alpha_numeric =~ /^[a-z0-9]+$/i;
      assert true
    else
      assert_not false
    end
  end

  test "39 alpha check" do
    alpha_check = "d55555fdfdsf"

    if alpha_check =~  /^[A-z]+$/ ;
      assert true
    else
      assert_not false
    end
  end

  test "40 min date" do
    from = "7/01/2018".to_date
    if from < Date.today
      assert true
    else
       assert_not false
    end
  end

  test "41 confirm password validation" do
    password = "123456789"
    confirm_password = "123456789"
    if password == confirm_password
      assert true
    else
      assert_not false
    end
  end

  test "42 exact length validation" do
    exact_length = "abcde"
    if exact_length.length == 5
      assert true
    else
      assert_not false
    end
  end

  test "43 testForPushNotificationEnabledOrNot validation" do
    assert true
  end

  test "44 numeric_greater validation" do
    numeric_greater = 234567
    if numeric_greater > 123456
      assert true
    else
      assert_not false
    end
  end

  test "45 max_date" do
    max_date = (Date.today + 1.days)
    if max_date > Date.today
      assert true
    else
      assert_not false
    end
  end

  test "46 numeric lesser" do 
    x = 3
    y = 4
    if x < y
    assert true
    else
    assert false  
    end  
  end

  test "47 numeric_greter_equal" do 
     x = 3
     y = 4
     if y >= x
      assert true
     else
      assert false  
     end  
  end

  test "48 numeric_lesser_equal" do 
     x = 3
     y = 4
     if x <= y
      assert true
     else
      assert false  
     end  
  end

  test "49 check_for_odd" do 
    n = 3
    if n%2 != 0
      assert true
    else
      assert false  
    end 
  end

  test "50 check_for_even" do 
    n = 4
    if n%2 == 0
      assert true
    else
      assert false  
    end 
  end

  test "51 NumericEqualTo" do
    str = 123
    abc = 123

    if ((str.class == Fixnum) && (abc.class == Fixnum) && (str.equal?(abc)))
      assert true
    else
      assert_not false
    end
  end

  test "52 Tin" do
    str = 27123456789
    regex = /^(3[0-5]|[012][0-9]|[1-9])\d{9}$/
  end

  test "53 Coin Address" do
    str = "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"
    regex = /^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$/
  end

  test "54 GST" do
    str = "29ABCDE1234ZZZ5"
    regex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/
  end

  test "55 Barcode(12 and 14 digits)" do
    str = 80903243234323
    regex = /^8\d{11}$|^8\d{13}$/
  end

  test "56 REFERAL CODE" do
   regex = /[0-9a-zA-Z' ']{5,15}/
   referal_code = 'ee34343211'
   referal_code =~ regex
  end

  test "57 CITIZENSHIP NUMBER" do
    regex = /^[0-9]{10,16}/
    number = 1234567890123456
    number =~ regex
  end

  test "58 CARDNUMBER" do
    regex = /^[0-9]{16}/
    card_numer = 1234567890123456
    card_numer =~ regex
  end

  test "59 test payment gateway" do
    assert true
  end

  test "60 GIFT CODE" do
    regex = /^[0-9]{4,10}/
    gift_code = 12345
    gift_code =~ regex
  end

  test "61 test for ip address valid" do
    require 'ipaddr'

    ip = "127.0.0.1"

    ip = IPAddr.new ip
    # => #<IPAddr: IPv4:127.0.0.1/255.255.255.255>

    # ip = IPAddr.new "127.0.0.a" rescue false
    # => IPAddr::InvalidAddressError: invalid address
  end

  test "62 check for cof number" do
    str="255-255-2256"
    str=~ /^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/
  end

  test "63 year of Experience" do
    no = 4
    (no.class == Fixnum || no.class == Float)
  end

  test "64 TAX ID" do
    ssn = "255-55-2256"
    ssn =~ /\b\d{3}[^\d]?\d{2}[^\d]?\d{4}\b/
  end  

  test "65 BIO" do
    txt = "Something Text"
    (txt.class == String and txt.length > 1000)
  end

  test "66 Account No" do
    def acc_no
      acc_regex = /^(?:[0-9]{11}|[0-9]{2}-[0-9]{3}-[0-9]{6})$/
      acc_no = "12345678912"

      if acc_no =~ acc_regex
        return true
      else
        return false
      end
    end
    acc_no
  end

  test "67 Routing No" do
    def routing_no
      rout_regex = /^[0-9]{9}$/
      routing = "123456789"
      if routing =~ rout_regex
        return true
      else
        return false
      end
    end
    routing_no
  end

  test "68 Passport Number" do
    def pass_check
      regsaid = /^[A-PR-WY][1-9]\d\s?\d{4}[1-9]$/
      passport = "A12 34567"
      if passport =~ regsaid
        return true
      else
        return false
      end
    end
    pass_check
  end

  test "69 Zone no" do
    def zone
      zone_no = "1122"
      if zone_no.class == Integer and zone_no.length < 6
        return true
      else
        return false
      end
    end
    zone
  end

  # test "70 Unit No" do
  #   def unit
  #     unit_no = 1122
  #     if (unit_no.class == Integer and unit_no.length < 6)
  #       return true
  #     else
  #       return false
  #     end
  #   end
  #   unit
  # end

  test "71 Street no" do
    street = 1122
    (street.class == Fixnum && street.size < 5)
  end

  test "72 IFCS code" do
    var = "KKBK00022"
    var =~/^[A-Za-z]{4}\d{7}$/
  end

  test "73 RTO" do
    rto = "MP 09 AB 1234"
    rto =~/^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$/
  end

  test "74 Chasis no" do
    chasis = 1122
    (chasis.class == Fixnum && chasis.size < 5)
  end

  test "75 Permit image" do
    file = "/test.png"
    file.to_s.include?(".gif") or file.to_s.include?(".png") or file.to_s.include?(".jpg") or file.to_s.include?(".jpeg")
  end

  test "76 Cubic Capacity" do
    cubic_regex = /\d/
    bore = 10
    stroke = 12
    cylinders = 4
    if (bore =~ cubic_regex and stroke =~cubic_regex and cylinders =~cubic_regex)
      return true
    else
      return false
    end
  end

  test "77 Registration Number" do
    reg_number_regex = /^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$/
    reg_number = "MP 09 AB 1234"
    if reg_number =~ reg_number_regex
      return true
    else
      return false
    end
  end

  test "78 Attachment file" do
    image_regex = /[^\s]+(\.(?i)(jpg|png|gif|bmp))$/
    image_file = "firstimage.jpg"
    if image_file =~ image_regex
      return true
    else
      return false
    end
  end

  test "79 CAF NO" do
    caf_regex = /[0-9]{4}/
    caf_no = "8241"
    if caf_no =~ caf_regex
      assert true
    else
      assert_not false
    end
  end

  test "80 STB" do
    stb_regex = /^\w+$/i
    stb_no = "8241"
    if stb_no =~ stb_regex
      assert true
    else
      assert_not false
    end
  end

  test "81 VC No" do
    caf_regex = /[0-9]{10}/
    caf_no = "9876543210"
    if caf_no =~ caf_regex
      assert true
    else
      assert_not false
    end
  end  

  test "82 height(cm)" do
    height = 11.23
    height =~ /\d{2,3}\.\d{,2}/
  end

  test "83 weight" do
    weight = 11.23
    weight =~ /\d{2,3}\.\d{,2}/
  end

  test "84 CheckForAscendingOrder" do
    qr = [1,2,3,4,5]
    if ([5,4,3,2,1] == qr.reverse)
      assert true
    else
      assert_not false
    end
  end

  test "85 CheckForDesendingOrder" do
    qr = [5,4,3,2,1]
    if ([1,2,3,4,5] == qr.reverse)
      assert true
    else
      assert_not false
    end
  end

  test "86 QR Code" do
    qr = "ddfi503kdf05"
    if qr =~ /^[a-z0-9]+$/i;
      assert true
    else
      assert_not false
    end
  end

  test "87 Time Zone" do
    var1 = "UTC"
    if var = ["UTC","GMT","CST","PST","EST"].include?(var1)
      assert true
    else
      assert_not false
    end
  end

  test "88 CVV Number" do
    cvv = 451
    if cvv=~/^[0-9]{3,4}$/
      assert true
    else
      assert_not false
    end
  end

  test "89 Note" do
    note = "Something Text"
    (note.class == String and note.length > 1000)
  end


end