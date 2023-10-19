import 'package:todo_statemanagement/common/common.dart';
import 'package:todo_statemanagement/screen/main/tab/home/banks_dummy.dart';
import 'package:todo_statemanagement/screen/main/tab/home/vo/vo_bank_account.dart';

final bankAccountShinhan1 =
    BankAccount(1, bankShinhan, 300, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan2 =
    BankAccount(2, bankShinhan, 200, accountTypeName: "저축예금");
final bankAccountShinhan3 =
    BankAccount(3, bankShinhan, 100, accountTypeName: "저축예금");
final bankAccountToss = BankAccount(4, bankTtoss, 400);
final bankAccountKakao =
    BankAccount(5, bankKakao, 70000, accountTypeName: "입출금통장");
final bankAccountKakao2 =
    BankAccount(6, bankKakao, 1000000, accountTypeName: "특별통장");

abstract class Animal {
  void eat();
}

class Dog extends Animal {
  void eat() {
    print('dog');
  }
}

class Cat extends Animal {
  void eat() {
    print('cat');
  }
}

class Cow extends Animal {
  void eat() {
    print('cow');
  }
}

main() {
  // 삽입
  bankAccounts.insert(1, bankAccountKakao2);

  // 위치 이동
  final temp = bankAccounts.removeAt(4);
  bankAccounts.insert(0, temp);

  // 교환
  bankAccounts.swap(0, 5);

  // 변환
  final banks = bankAccounts.map((e) => e.bank).toList();

  if (banks[3] != banks[5]) {}
  final uniqueBanks = banks.toSet();
  for (final bank in uniqueBanks) {
    print(bank.toString());
  }

  // 생성
  final list = [];

  final set = {bankAccountShinhan1, bankAccountShinhan2};
  final map = {
    "shinhan1": bankAccountShinhan1,
    "shinhan2": bankAccountShinhan2
  };

  // class generic
  final result = doTheWork();
  print(result.data);
  final result2 = doTheWork2();

  // method or function generic

  final result3 = doTheWork3<Dog>(() => Dog());
  result3.eat();
}

class Result<T> {
  final T data;

  Result(this.data);
}

class ResultString {
  final String data;

  ResultString(this.data);
}

class ResultDouble {
  final double data;

  ResultDouble(this.data);
}

Result<String> doTheWork() {
  ///...1
  ///...2
  ///
  ///...4
  return Result("중요한 데이터");
}

ResultDouble doTheWork2() {
  ///...1
  ///...2
  ///
  ///...4
  return ResultDouble(5234.44);
}

Result doTheWork3<Result extends Animal>(Result Function() animalCreator) {
  return animalCreator();
}

//List
final bankAccounts = [
  bankAccountShinhan1,
  bankAccountShinhan2,
  bankAccountShinhan3,
  bankAccountToss,
  bankAccountKakao
];

//Map
final bankMap = {
  "shinhan1": bankAccountShinhan1,
  "shinhan2": bankAccountShinhan2,
};

//Set
final bankSet = {
  bankAccountShinhan1,
  bankAccountShinhan2,
  bankAccountShinhan2,
  bankAccountShinhan2,
  bankAccountShinhan2,
  bankAccountShinhan3,
  bankAccountToss,
  bankAccountKakao
};
