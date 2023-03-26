using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Threading;
using TestTask1.BD;
using TestTask1.Model;
using TestTask1.ViewModel;

namespace TestTask1
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Model1 model1 = new Model1();
        List<OrderModel> OrdersM = new List<OrderModel>();
        List<ReplenishmentsModel> ReplenishmentsM = new List<ReplenishmentsModel>();

        bool HisButOrder = false;
        bool HisButOrder2 = false;

        int HisButOrderID = 0;
        int HisButReplenishmentID = 0;
        private static DispatcherTimer _dataUpdateTimer = null;
        MainWindowViewModel viewModel;

        public MainWindow()
        {
            #region Таймер OnDataUpdateEvent
            _dataUpdateTimer = new DispatcherTimer();
            _dataUpdateTimer.Tick += OnDataUpdateEvent;
            _dataUpdateTimer.Interval = TimeSpan.FromMilliseconds(1000);
            _dataUpdateTimer.Start();
            #endregion

            InitializeComponent();
            OrdersM.AddRange(DataOrder(model1.Orders.ToList()));
            ReplenishmentsM.AddRange(DataReplenishments(model1.Replenishments.ToList()));

            viewModel = new MainWindowViewModel(OrdersM, model1.Payments.ToList(), ReplenishmentsM);
            this.DataContext = viewModel;



        }
        private void OnDataUpdateEvent(object sender, EventArgs e)
        {


            model1 = new Model1();
            List<OrderModel> y = new List<OrderModel>();
            y.Clear();
            y.AddRange(DataOrder(model1.Orders.ToList()));

            List<ReplenishmentsModel> y2 = new List<ReplenishmentsModel>();
            y2.Clear();
            y2.AddRange(DataReplenishments(model1.Replenishments.ToList()));

            bool isEqual = EqualsList(OrdersM, y);
            bool isEqual2 = EqualsListR(ReplenishmentsM, y2);


           


                if (!isEqual || !isEqual2)
                {
                    GridPayments.ItemsSource = model1.Payments.ToList();

                    OrdersM.Clear();
                    OrdersM.AddRange(y);
                    dataGridOrder.ItemsSource = OrdersM;
                    dataGridOrder.Items.Refresh();
                    if (dataGridOrder.SelectedItem != null)
                    {
                        OrderModel f = (OrderModel)dataGridOrder.SelectedItem;
                        dataGridOrder.SelectedItem = OrdersM.Where(c => c.ID == f.ID).FirstOrDefault();
                    }



                    ReplenishmentsM.Clear();
                    ReplenishmentsM.AddRange(y2);
                    dataGridReplenishments.ItemsSource = ReplenishmentsM;
                    dataGridReplenishments.Items.Refresh();
                    if (dataGridReplenishments.SelectedItem != null)
                    {
                        ReplenishmentsModel f2 = (ReplenishmentsModel)dataGridReplenishments.SelectedItem;
                        dataGridReplenishments.SelectedItem = ReplenishmentsM.Where(c => c.ID == f2.ID).FirstOrDefault();
                    }



                }
            
            if (HisButOrder)
            {
                GridPayments.ItemsSource = model1.Payments.Where(x => x.OrderID == HisButOrderID).ToList();
                GridPayments.Items.Refresh();
            }
            if (HisButOrder2)
            {
                GridPayments.ItemsSource = model1.Payments.Where(x => x.ReplenishmentID == HisButReplenishmentID).ToList();
                GridPayments.Items.Refresh();
            }


        }

        #region Сравненеие 2-х List<T>

        /// <summary>
        /// Сравнение двух list<OrderModel>
        /// </summary>
        /// <returns>Bool результат сравнения</returns>
        private bool EqualsList(List<OrderModel> List1, List<OrderModel> List2)
        {
            List1 = List1.OrderBy(si => si.ID).ToList();
            List2 = List2.OrderBy(si => si.ID).ToList();
            if (List1.Count() == List2.Count())
            {
                for (int i = 0; i < List1.Count(); i++)
                {
                    if (!List1[i].Equals(List2[i]))
                    {
                        return false;
                    }

                }
            }
            else
            {
                return false;
            }

            return true;
        }


        /// <summary>
        /// Сравнение двух list<ReplenishmentsModel>
        /// </summary>
        /// <returns>Bool результат сравнения</returns>
        private bool EqualsListR(List<ReplenishmentsModel> List1, List<ReplenishmentsModel> List2)
        {
            List1 = List1.OrderBy(si => si.ID).ToList();
            List2 = List2.OrderBy(si => si.ID).ToList();
            if (List1.Count() == List2.Count())
            {
                for (int i = 0; i < List1.Count(); i++)
                {
                    if (!List1[i].Equals(List2[i]))
                    {
                        return false;
                    }

                }
            }
            else
            {
                return false;
            }

            return true;
        }
        #endregion


        #region Создание массива модели


        private List<OrderModel> DataOrder(List<Orders> x)
        {
            List<OrderModel> list = new List<OrderModel>();
            foreach (var item in x)
            {
                OrderModel orderModel = new OrderModel() { Amount = item.Amount, Date = item.Date, ID = item.ID, PaymentAmount = item.PaymentAmount };
                list.Add(orderModel);
            }
            return list;
        }

        private List<ReplenishmentsModel> DataReplenishments(List<Replenishments> x)
        {
            List<ReplenishmentsModel> list = new List<ReplenishmentsModel>();
            foreach (var item in x)
            {
                ReplenishmentsModel orderModel = new ReplenishmentsModel(item);
                list.Add(orderModel);
            }
            return list;
        }

        #endregion


        private void Button_Click(object sender, RoutedEventArgs e)
        {

        }


        #region Выбор элементов
        private void dataGridOrder_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            var Grid = (DataGrid)sender;

            var Order = Grid.SelectedItem as OrderModel;
            if (Order != null)
            {

                NameOrder.Content = "Выбран заказ № " + Order.ID;
                HisButOrderID = Order.ID;
                check();
            }


        }

        private void dataGridReplenishments_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var Grid = (DataGrid)sender;
            var Replenishment = Grid.SelectedItem as ReplenishmentsModel;
            if (Replenishment != null)
            {

                HisButReplenishmentID = Replenishment.ID;
                NameRepl.Content = "Приход денег:№ " + Replenishment.ID;


                check();
            }


        }
        #endregion


        #region Сортировка элементов
        private void HistoryBut_Click(object sender, RoutedEventArgs e)
        {

            model1 = new Model1();
            GridPayments.ItemsSource = model1.Payments.Where(x => x.OrderID == HisButOrderID).ToList();
            GridPayments.Items.Refresh();
            HisButOrder = true;
            HisButOrder2 = false;
            HistoryBut.IsEnabled = false;
            HistoryBut2.IsEnabled = true;

        }
        private void HistoryBut2_Click(object sender, RoutedEventArgs e)
        {
            model1 = new Model1();
            GridPayments.ItemsSource = model1.Payments.Where(x => x.ReplenishmentID == HisButReplenishmentID).ToList();
            GridPayments.Items.Refresh();
            HisButOrder2 = true;
            HisButOrder = false;
            HistoryBut.IsEnabled = true;
            HistoryBut2.IsEnabled = false;

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            model1 = new Model1();
            GridPayments.ItemsSource = model1.Payments.ToList();
            GridPayments.Items.Refresh();
            HisButOrder = false;
            HisButOrder2 = false;
            HistoryBut.IsEnabled = true;
            HistoryBut2.IsEnabled = true;
        }


        #endregion


        public void check()
        {

            But.Content = string.Empty;
            But.IsEnabled = false;

            if (HisButReplenishmentID != 0)
            {

                if (model1.Replenishments.Where(x => x.ID == HisButReplenishmentID).FirstOrDefault().Remains == 0)
                {
                    But.Content = "Остаток 0";
                }
            }
            if (HisButOrderID != 0)
            {
                var ord = model1.Orders.Where(x => x.ID == HisButOrderID).FirstOrDefault();

                if (ord.PaymentAmount == ord.Amount)
                {
                    if (But.Content.ToString() == string.Empty)
                        But.Content += "Заказ оплачен";
                    else
                        But.Content += "\nЗаказ оплачен";
                }

            }

            if (But.Content.ToString() == string.Empty)
            {
                if (HisButReplenishmentID != 0 && HisButOrderID != 0)
                {
                    But.IsEnabled = true;
                    But.Content = "Оплатить";
                }
                else
                {
                    But.IsEnabled = false;
                    But.Content = "Оплатить";
                }
            }





        }

        private void But_Click(object sender, RoutedEventArgs e)
        {
            Payments payments = new Payments() { OrderID = HisButOrderID, ReplenishmentID = HisButReplenishmentID, Amount = 0 };
            model1.Payments.Add(payments);
            model1.SaveChanges();


        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Orders orders = new Orders() { Amount = int.Parse(Sum.Text), PaymentAmount = 0 };
            model1.Orders.Add(orders);
            model1.SaveChanges();
        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            Replenishments replenishments = new Replenishments() { Amount = int.Parse(Rep.Text) };
            model1.Replenishments.Add(replenishments);
            model1.SaveChanges();
        }
    }
}
