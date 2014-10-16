#include <SDKDDKVer.h>
#include "CppUnitTest.h"
#include "../ConsoleApplication1/LinkedList.h"

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace UnitTest1
{
	TEST_CLASS(UnitTest1)
	{
	public:
		LinkedList<int> list;

		TEST_METHOD(insert)
		{
			list.insert(0, 300);
			Assert::AreEqual(300, list.get(0));
			Assert::ExpectException<std::exception>([this]{ list.insert(33, 200); });
		}

		TEST_METHOD(getElement)
		{
			list.add(300);
			Element<int> *element = list.getElement(0);
			Assert::AreEqual(element->getValue(), list.get(0));
		}

		TEST_METHOD(add)
		{
			list.add(23);
			list.add(34);
			Assert::AreEqual(34, list.get(1));
		}

		TEST_METHOD(get)
		{
			list.add(23);
			int object = list.get(0);
			Assert::AreEqual(23, object);
			Assert::ExpectException<std::exception>([this]{ list.get(55); });
		}

		TEST_METHOD(set)
		{
			list.add(23);
			list.add(34);
			list.add(65);
			list.add(7);
			list.set(2, 99);
			Assert::AreEqual(99, list.get(2));
		}

		TEST_METHOD(indexOf)
		{
			list.add(23);
			list.add(34);
			list.add(65);
			list.add(7);
			Assert::AreEqual(2, list.indexOf(65));
		}

		TEST_METHOD(contains)
		{
			list.add(23);
			list.add(34);
			list.add(65);
			list.add(7);
			Assert::AreEqual(true, list.contains(34));
			Assert::AreEqual(false, list.contains(12));
		}

		TEST_METHOD(deleteValue)
		{
			list.add(23);
			list.add(34);
			list.add(65);
			list.add(7);
			list.deleteValue(34);
			Assert::AreEqual(false, list.contains(34));
		}

		TEST_METHOD(deleteObject)
		{
			list.add(29);
			list.add(38);
			list.add(45);
			list.add(99);
			list.deleteObject(2);
			Assert::AreEqual(false, list.contains(45));
		}

		TEST_METHOD(size)
		{
			list.add(23);
			list.add(34);
			list.add(65);
			list.add(7);
			Assert::AreEqual(4, list.size());
		}

		TEST_METHOD(isEmpty)
		{
			Assert::AreEqual(true, list.isEmpty());
			list.add(23);
			list.add(34);
			list.add(65);
			list.add(7);
			Assert::AreEqual(false, list.isEmpty());
		}

		TEST_METHOD(clear)
		{
			list.add(23);
			list.add(34);
			list.add(65);
			list.add(7);
			list.clear();
			Assert::AreEqual(true, list.isEmpty());
		}
	};
}